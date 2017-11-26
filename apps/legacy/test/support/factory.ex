defmodule Legacy.Factory do
  @moduledoc """
  Factory for testsing.
  """
  use ExMachina.Ecto, repo: Legacy.Repo

  def user_factory do
    %Legacy.Accounts.User{
      Username: sequence(:username, &"username#{&1}"),
      Status: "A",
      Admin: false,
      Name: "Bob",
      Email: sequence(:email, &"email#{&1}@example.com"),
      slug: sequence(:slug, &"username-#{&1}"),
      Approval: false,
      Emailed: false,
      EmailVal: false,
    }
  end

end
