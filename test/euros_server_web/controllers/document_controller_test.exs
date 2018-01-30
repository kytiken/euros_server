defmodule EurosServerWeb.DocumentControllerTest do
  use EurosServerWeb.ConnCase

  alias EurosServer.Spiders
  alias EurosServer.Spiders.Document

  @create_attrs %{body: "some body", url: "some url"}
  @update_attrs %{body: "some updated body", url: "some updated url"}
  @invalid_attrs %{body: nil, url: nil}

  def fixture(:document, crawl_id) do
    {:ok, document} = Spiders.create_document(%{@create_attrs | crawl_id: crawl_id})
    document
  end

  def fixture(:crawl) do
    {:ok, crawl: crawl} = create_crawl()
    crawl
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all documents", %{conn: conn} do
      crawl = fixture(:crawl)
      conn = get(conn, crawl_document_path(conn, :index, crawl.id))
      assert json_response(conn, 200)["data"] == []
    end
  end

  defp create_document(_) do
    crawl = fixture(:crawl)
    document = fixture(:document, crawl.id)
    {:ok, document: document, crawl: crawl}
  end

  defp create_crawl() do
    {:ok, crawl} = Spiders.create_crawl(%{url: "http://example.com", timeout: 0, recv_timeout: 0})
    {:ok, crawl: crawl}
  end
end
