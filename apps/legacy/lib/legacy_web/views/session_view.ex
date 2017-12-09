defmodule LegacyWeb.SessionView do
  use LegacyWeb, :view

  def render("info.json", %{info: token}) do
    %{access_token: token}
  end
end
