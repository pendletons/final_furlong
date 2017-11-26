defmodule LegacyWeb.PageView do
  use LegacyWeb, :view

  def render("index.json", _) do
    %{data: "Hello World"}
  end
end
