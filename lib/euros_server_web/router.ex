defmodule EurosServerWeb.Router do
  use EurosServerWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", EurosServerWeb do
    pipe_through(:api)

    resources "/crawls", CrawlController, except: [:new, :edit] do
      resources("/documents", DocumentController, except: [:new, :edit, :create, :update])
    end

    options("/crawls", CrawlController, :options)
  end
end
