defmodule Lic.Router do
  use Lic.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Lic.Auth, repo: :nothing
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Lic do
    pipe_through :browser
    get "/", PageController, :index
    resources "/search", SearchController, only: [:create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/manage", Lic do
    pipe_through [:browser, :authenticate]
    resources "/products", ProductController
    delete "/licenses/:id/:product", LicenseController, :delete
    resources "/licenses", LicenseController, except: [:show, :new, :delete]
    get "/licenses/new/:product_id", LicenseController, :new
    get "/index", PageController, :admin
  end

  # Other scopes may use custom stacks.
  # scope "/api", Lic do
  #   pipe_through :api
  # end
end
