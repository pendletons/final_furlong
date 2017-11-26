defmodule FinalFurlongWeb.PasswordResetController do
  use FinalFurlongWeb, :controller
  alias FinalFurlong.Accounts
  alias FinalFurlong.Accounts.Message
  alias Phauxth.Confirm

  def create(conn, %{"password_reset" => %{"email" => email}}) do
    key = Accounts.create_password_reset(FinalFurlongWeb.Endpoint, %{"email" => email})
    Accounts.Message.reset_request(email, key)
    message = "Check your inbox for instructions on how to reset your password"
    conn
    |> put_status(:created)
    |> render(FinalFurlongWeb.PasswordResetView, "info.json", %{info: message})
  end

  def update(conn, %{"password_reset" => params}) do
    case Confirm.verify(params, Accounts, mode: :pass_reset) do
      {:ok, user} ->
        user
        |> Accounts.update_password(params)
        |> update_password(conn, params)
      {:error, message} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(FinalFurlongWeb.PasswordResetView, "error.json", error: message)
    end
  end

  defp update_password({:ok, user}, conn, _params) do
    Message.reset_success(user.email)
    message = "Your password has been reset"
    render(conn, FinalFurlongWeb.PasswordResetView, "info.json", %{info: message})
  end
  defp update_password({:error, %Ecto.Changeset{} = changeset}, conn, _params) do
    message = with p <- changeset.errors[:password], do: elem(p, 0)
    conn
    |> put_status(:unprocessable_entity)
    |> render(FinalFurlongWeb.PasswordResetView, "error.json", error: message || "Invalid input")
  end
end
