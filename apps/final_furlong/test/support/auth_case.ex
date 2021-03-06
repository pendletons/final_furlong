defmodule FinalFurlongWeb.AuthCase do
  @moduledoc """
  This module adds helper methods for creating users with authentication.
  """
  use Phoenix.ConnTest

  import Ecto.Changeset
  alias FinalFurlong.{Accounts, Repo}
  alias Phauxth.Token

  def add_user(email) do
    user = %{email: email, password: "reallyHard2gue$$"}
    {:ok, user} = Accounts.create_user(user)
    user
  end

  def add_user_confirmed(email) do
    email
    |> add_user
    |> change(%{confirmed_at: DateTime.utc_now})
    |> Repo.update!
  end

  def add_reset_user(email) do
    email
    |> add_user
    |> change(%{confirmed_at: DateTime.utc_now})
    |> change(%{reset_sent_at: DateTime.utc_now})
    |> Repo.update!
  end

  def add_token_conn(conn, user) do
    user_token = Token.sign(FinalFurlongWeb.Endpoint, user.id)
    conn
    |> put_req_header("accept", "application/json")
    |> put_req_header("authorization", user_token)
  end

  def gen_key(email) do
    Token.sign(FinalFurlongWeb.Endpoint, %{"email" => email})
  end
end
