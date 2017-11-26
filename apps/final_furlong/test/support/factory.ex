defmodule FinalFurlong.Factory do
  @moduledoc """
  This module adds test data setup functions.
  """
  use ExMachina.Ecto, repo: FinalFurlong.Repo

  def user_factory do
    %FinalFurlong.Accounts.User{
      email: sequence(:email, &"user#{&1}@example.com"),
      password: "password123",
    }
  end
end
