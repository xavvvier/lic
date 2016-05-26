defmodule Lic.Router do
  use Lic.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/manage", Lic do
    pipe_through :browser
    resources "/products", ProductController
    delete "/licenses/:id/:product", LicenseController, :delete
    resources "/licenses", LicenseController, except: [:show, :new, :delete]
    get "/licenses/new/:product_id", LicenseController, :new
  end

  scope "/", Lic do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/search", SearchController, only: [:create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Lic do
  #   pipe_through :api
  # end
end
