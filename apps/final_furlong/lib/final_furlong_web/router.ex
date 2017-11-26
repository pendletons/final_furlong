defmodule FinalFurlongWeb.Router do
  use FinalFurlongWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Phauxth.Authenticate, method: :token
  end

  scope "/", FinalFurlongWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", FinalFurlongWeb do
    pipe_through :api

    post "/sessions", SessionController, :create
    resources "/users", UserController, except: [:new, :edit]
    get "/confirm", ConfirmController, :index
    post "/password_resets", PasswordResetController, :create
    put "/password_resets/update", PasswordResetController, :update
  end

  if Mix.env == :dev do
    # If using Phoenix
    forward "/sent_emails", Bamboo.EmailPreviewPlug
  end

end
