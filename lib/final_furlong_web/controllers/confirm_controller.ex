defmodule FinalFurlongWeb.ConfirmController do
  use FinalFurlongWeb, :controller

  import FinalFurlongWeb.Authorize
  alias FinalFurlong.Accounts
  alias FinalFurlong.Accounts.Message
  alias Phauxth.Confirm

  def index(conn, params) do
    case Confirm.verify(params, Accounts) do
      {:ok, user} ->
        Accounts.confirm_user(user)
        message = "Your account has been confirmed"
        Message.confirm_success(user.email)
        render(conn, FinalFurlongWeb.ConfirmView, "info.json", %{info: message})
      {:error, _message} ->
        error(conn, :unauthorized, 401)
    end
  end
end
