# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# It is also run when you use the command `mix ecto.setup`
#

users = [
  %{email: "jane@example.com", password: "password"},
  %{email: "john@example.org", password: "password"}
]

for user <- users do
  {:ok, user} = FinalFurlong.Accounts.create_user(user)
  FinalFurlong.Accounts.confirm_user(user)
end
