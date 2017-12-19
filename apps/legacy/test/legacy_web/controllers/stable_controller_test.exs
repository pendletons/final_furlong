defmodule LegacyWeb.StableControllerTest do
  use LegacyWeb.ConnCase

  import Legacy.Factory
  import LegacyWeb.AuthCase

  alias Legacy.{Accounts, Repo}

  setup %{conn: conn} do
    user = insert(:user)
    legacy_user_params = Ecto.build_assoc(user, :legacy_user, params_for(:legacy_user))
    legacy_user = Repo.insert!(legacy_user_params)
    stable = Accounts.get_stable(legacy_user."ID")
    conn = conn |> add_token_conn(user)
    {:ok, %{conn: conn, user: user, stable: stable}}
  end

  test "GET /stables", %{conn: conn} do
    conn = get conn, stable_path(conn, :index)
    assert json_response(conn, 200) #["data"] == "Hello World"
  end

  test "GET /stables/:id", %{conn: conn} do
    legacy_user = insert(:legacy_user)
    stable = Accounts.get_stable(legacy_user."ID")
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
    other_legacy_user = insert(:legacy_user)
    other_stable = Accounts.get_stable(other_legacy_user."ID")
    refute stable == other_stable
    update_attrs = %{"Description" => "foo bar"}
    conn = put conn, stable_path(conn, :update, other_stable), stable: update_attrs
    assert json_response(conn, 401)["error"] =~ "Unauthorized"
    refute Accounts.get_stable(other_stable."ID")."Description" == "foo bar"
  end
end
