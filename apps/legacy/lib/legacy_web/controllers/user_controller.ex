defmodule LegacyWeb.UserController do
  use LegacyWeb, :controller
  use LegacyWeb.Controller

  import LegacyWeb.Authorize
  alias Phauxth.Log
  alias Legacy.Accounts

  action_fallback LegacyWeb.FallbackController

  # the following plugs are defined in the controllers/authorize.ex file
  plug :user_check when action in [:index, :show]
  plug :id_check when action in [:update, :delete]

  def index(conn, _params, _current_user) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}, _current_user) do
    with {:ok, user} <- Accounts.create_user(user_params) do
      Log.info(%Log{user: user.id, message: "user created"})
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}, current_user) do
    user = id == to_string(current_user.id) and current_user || Accounts.get(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"user" => user_params}, current_user) do
    with {:ok, user} <- Accounts.update_user(current_user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, _params, current_user) do
    {:ok, _user} = Accounts.delete_user(current_user)
    send_resp(conn, :no_content, "")
  end
end
