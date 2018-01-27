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
    pipe_through :api

    resources "/crawls", CrawlController, except: [:new, :edit]
    options   "/crawls", CrawlController, :options
    resources "/documents", DocumentController, except: [:new, :edit]
  end
end
