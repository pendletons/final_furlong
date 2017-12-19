defmodule MasterProxy.Application do
  @moduledoc """
  Proxy requests to web apps that are part of the platform.
  """
  use Application

  alias Plug.Adapters.Cowboy

  def start(_type, _args) do
    import Supervisor.Spec

    port = (System.get_env("PORT") || "3333") |> String.to_integer
    cowboy = Cowboy.child_spec(:http, MasterProxy.Plug, [], [port: port])

    # Define workers and child supervisors to be supervised
    children = [
      cowboy
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MasterProxy.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
