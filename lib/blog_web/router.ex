defmodule BlogWeb.Router do
  use BlogWeb, :router

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

  scope "/", BlogWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/hello", HelloController, :index
    get "/hello/:someone", HelloController, :show

    resources "/users", UserController do
      resources "/posts", PostController
    end

    resources "/reviews", ReviewController
    # resources "/comments", CommentController, except: [:delete]
  end

  scope "/admin", BlogWeb.Admin, as: :admin do
    pipe_through :browser

    resources "/images", ImageController
    resources "/reviews", ReviewController
    resources "/users", UserController
  end

  forward "/jobs", BackgroundJob.Plug, name: "Admin Panel"

  # Other scopes may use custom stacks.
  # scope "/api", BlogWeb do
  #   pipe_through :api
  # end
end
