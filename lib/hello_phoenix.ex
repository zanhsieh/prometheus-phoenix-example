defmodule HelloPhoenix do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    Prometheus.PlugsInstrumenter.setup()
    Prometheus.PlugsExporter.setup()
    Prometheus.PhoenixInstrumenter.setup()
    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(HelloPhoenix.Repo, []),
      # Start the endpoint when the application starts
      supervisor(HelloPhoenix.Endpoint, []),
      # Start your own worker by calling: HelloPhoenix.Worker.start_link(arg1, arg2, arg3)
      # worker(HelloPhoenix.Worker, [arg1, arg2, arg3]),
      Plug.Adapters.Cowboy.child_spec(:http, Stack, [], [port: 4001])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
    
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    HelloPhoenix.Endpoint.config_change(changed, removed)
    :ok
  end
end

defmodule Stack do
  use Plug.Builder

  plug Prometheus.PlugsInstrumenter
  plug Prometheus.PlugsExporter
  plug Prometheus.PhoenixInstrumenter
end
