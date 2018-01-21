defmodule EurosServerWeb.DocumentController do
  use EurosServerWeb, :controller

  alias EurosServer.Spiders
  alias EurosServer.Spiders.Document

  action_fallback EurosServerWeb.FallbackController

  def index(conn, _params) do
    documents = Spiders.list_documents()
    render(conn, "index.json", documents: documents)
  end

  def create(conn, %{"document" => document_params}) do
    with {:ok, %Document{} = document} <- Spiders.create_document(document_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", document_path(conn, :show, document))
      |> render("show.json", document: document)
    end
  end

  def show(conn, %{"id" => id}) do
    document = Spiders.get_document!(id)
    render(conn, "show.json", document: document)
  end

  def update(conn, %{"id" => id, "document" => document_params}) do
    document = Spiders.get_document!(id)

    with {:ok, %Document{} = document} <- Spiders.update_document(document, document_params) do
      render(conn, "show.json", document: document)
    end
  end

  def delete(conn, %{"id" => id}) do
    document = Spiders.get_document!(id)
    with {:ok, %Document{}} <- Spiders.delete_document(document) do
      send_resp(conn, :no_content, "")
    end
  end
end
