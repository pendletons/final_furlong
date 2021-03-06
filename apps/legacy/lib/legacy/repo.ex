defmodule Legacy.Repo do
  use Ecto.Repo, otp_app: :legacy
  use Scrivener, page_size: 50

  @doc """
  Dynamically loads the repository url from the
  MYSQL_DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("MYSQL_DATABASE_URL"))}
  end
end
