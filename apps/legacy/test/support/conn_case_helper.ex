defmodule LegacyWeb.ConnCaseHelper do
  @moduledoc """
  Helper functions to allow controllers to test against view output.
  """

  @doc """
  Render a view output as JSON.
  ## Examples
      iex> render_json(TestView, "show.json", %{"foo" => :bar})
      '{"foo": :bar}'
  """
  def render_json(view, template, assigns) do
    format_json(view.render(template, assigns))
  end

  def format_json(data) do
    data |> Poison.encode! |> Poison.decode!
  end
end
