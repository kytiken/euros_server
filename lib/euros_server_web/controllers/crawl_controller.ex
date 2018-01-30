defmodule EurosServerWeb.CrawlController do
  use EurosServerWeb, :controller

  alias EurosServer.Spiders
  alias EurosServer.Spiders.Crawl

  action_fallback(EurosServerWeb.FallbackController)

  def index(conn, _params) do
    crawls = Spiders.list_crawls()
    render(conn, "index.json", crawls: crawls)
  end

  def create(conn, %{"crawl" => crawl_params}) do
    with {:ok, %Crawl{} = crawl} <- Spiders.create_crawl(crawl_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", crawl_path(conn, :show, crawl))
      |> render("show.json", crawl: crawl)

      spawn(fn -> EurosServer.Spiders.Crawl.execute(crawl) end)
    end
  end

  def show(conn, %{"id" => id}) do
    crawl = Spiders.get_crawl!(id)
    render(conn, "show.json", crawl: crawl)
  end

  def update(conn, %{"id" => id, "crawl" => crawl_params}) do
    crawl = Spiders.get_crawl!(id)

    with {:ok, %Crawl{} = crawl} <- Spiders.update_crawl(crawl, crawl_params) do
      render(conn, "show.json", crawl: crawl)
    end
  end

  def delete(conn, %{"id" => id}) do
    crawl = Spiders.get_crawl!(id)

    with {:ok, %Crawl{}} <- Spiders.delete_crawl(crawl) do
      send_resp(conn, :no_content, "")
    end
  end
end
