defmodule FinalFurlongWeb.SessionView do
  use FinalFurlongWeb, :view

  def render("info.json", %{info: token}) do
    %{access_token: token}
  end
end
