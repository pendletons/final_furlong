defmodule LegacyWeb.StableView do
  use LegacyWeb, :view
  use JaSerializer.PhoenixView

  attributes [:StableName, :Description]
end
