defmodule FinalFurlongWeb.ConfirmView do
  use FinalFurlongWeb, :view

  def render("info.json", %{info: message}) do
    %{info: %{detail: message}}
  end
end
