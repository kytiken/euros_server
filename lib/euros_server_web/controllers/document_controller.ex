defmodule EurosServerWeb.DocumentController do
  use EurosServerWeb, :controller

  alias EurosServer.Spiders
  alias EurosServer.Spiders.Document

  action_fallback(EurosServerWeb.FallbackController)

  def index(conn, %{"crawl_id" => crawl_id}) do
    crawl =
      crawl_id
      |> EurosServer.Spiders.get_crawl!()
      |> EurosServer.Repo.preload(:documents)

    documents = crawl.documents
    render(conn, "index.json", documents: documents)
  end

  def show(conn, %{"id" => id}) do
    document = Spiders.get_document!(id)
    render(conn, "show.json", document: document)
  end
end
