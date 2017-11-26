defmodule LegacyWeb.StableControllerTest do
  use LegacyWeb.ConnCase

  import Legacy.Factory

  test "GET /stables", %{conn: conn} do
    conn = get conn, stable_path(conn, :index)
    assert json_response(conn, 200) #["data"] == "Hello World"
  end

  test "GET /stables/:id", %{conn: conn} do
    stable = insert(:stable)
    conn = get conn, stable_path(conn, :show, stable."StableName")
    assert json_response(conn, 200)["data"]
  end
end
