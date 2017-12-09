defmodule LegacyWeb.Router do
  use LegacyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Phauxth.Authenticate, method: :token
  end

  scope "/api/legacy", LegacyWeb do
    pipe_through :api

    post "/sessions", SessionController, :create
    resources "/users", UserController, except: [:new, :edit]
    resources "/stables", StableController, only: [:index, :show, :update]
  end

end
