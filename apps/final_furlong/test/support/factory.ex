defmodule FinalFurlong.Factory do
  use ExMachina.Ecto, repo: FinalFurlong.Repo

  def user_factory do
    %FinalFurlong.Accounts.User{
      email: sequence(:email, &"user#{&1}@example.com"),
      password: "password123",
    }
  end
end
