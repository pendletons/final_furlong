defmodule FinalFurlongWeb.SessionController do
  use FinalFurlongWeb, :controller

  import FinalFurlongWeb.Authorize
  alias FinalFurlong.Accounts
  alias Phauxth.{Confirm.Login, Token}
  alias Comeonin.Pbkdf2

  plug :guest_check when action in [:create]

  # If you are using Argon2 or Pbkdf2, add crypto: Comeonin.Argon2
  # or crypto: Comeonin.Pbkdf2 to Login.verify (after Accounts)
  def create(conn, %{"session" => params}) do
    case Login.verify(params, Accounts, crypto: Pbkdf2) do
      {:ok, user} ->
        token = Token.sign(conn, user.id)
        render(conn, "info.json", %{info: token})
      {:error, _message} ->
        error(conn, :unauthorized, 401)
    end
  end
end
