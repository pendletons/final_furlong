defmodule MasterProxy.Plug do
  @moduledoc """
  Handle routing to the separate umbrella apps based on URL.
  """
  def init(options) do
    options
  end

  def call(conn, _opts) do
    if conn.request_path =~ ~r{/legacy} do
      LegacyWeb.Endpoint.call(conn, [])
    else
      FinalFurlongWeb.Endpoint.call(conn, [])
    end
  end
end
