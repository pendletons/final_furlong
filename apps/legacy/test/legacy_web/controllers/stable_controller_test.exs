defmodule LegacyWeb.StableControllerTest do
  use LegacyWeb.ConnCase

  import Legacy.Factory

  alias Legacy.Accounts

  setup %{conn: conn} do
    stable = insert(:stable)
    user = Accounts.get(stable."ID")
    conn = conn |> assign(:current_user, user)
    {:ok, %{conn: conn, user: user, stable: stable}}
  end

  test "GET /stables", %{conn: conn} do
    conn = get conn, stable_path(conn, :index)
    assert json_response(conn, 200) #["data"] == "Hello World"
  end

  test "GET /stables/:id", %{conn: conn} do
    stable = insert(:stable)
    conn = get conn, stable_path(conn, :show, stable."StableName")
    assert json_response(conn, 200)["data"]
  end

  test "PUT /stables/:id works with own stable", %{conn: conn, stable: stable} do
    update_attrs = %{"Description" => "foo bar"}
    conn = put conn, stable_path(conn, :update, stable), stable: update_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Accounts.get_stable(stable."ID")."Description" == "foo bar"
  end

  test "PUT /stables/:id errors with other stable", %{conn: conn, stable: stable} do
    other_stable = insert(:stable)
    refute stable == other_stable
    update_attrs = %{"Description" => "foo bar"}
    conn = put conn, stable_path(conn, :update, other_stable), stable: update_attrs
    assert json_response(conn, 401)["error"] =~ "Unauthorized"
    refute Accounts.get_stable(other_stable."ID")."Description" == "foo bar"
  end
end
