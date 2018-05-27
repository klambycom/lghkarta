defmodule Web.Router do
  use Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, origin: ~r/https?:\/\/(localhost|(\w+\.)?lghkarta\.se)(:[0-9]{1,4})?$/
    plug :accepts, ["json"]
  end

  scope "/", Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/fetch", PageController, :fetch
  end

  scope "/api" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug,
      schema: Web.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: Web.Schema,
      interface: :simple,
      context: %{pubsub: Web.Endpoint}
  end
end
