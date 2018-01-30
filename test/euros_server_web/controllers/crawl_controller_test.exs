defmodule EurosServerWeb.CrawlControllerTest do
  use EurosServerWeb.ConnCase

  alias EurosServer.Spiders
  alias EurosServer.Spiders.Crawl

  @create_attrs %{
    cookie: nil,
    depth_limit: 0,
    pattern: ".*",
    recv_timeout: 60000,
    timeout: 60000,
    url: "http://euros-test.blogspot.jp/"
  }
  @update_attrs %{
    cookie: "some updated cookie",
    depth_limit: 43,
    pattern: "some updated pattern",
    recv_timeout: 43,
    timeout: 43,
    url: "http://euros-test.blogspot.jp/"
  }
  @invalid_attrs %{
    cookie: nil,
    depth_limit: nil,
    pattern: nil,
    recv_timeout: nil,
    timeout: nil,
    url: nil
  }

  def fixture(:crawl) do
    {:ok, crawl} = Spiders.create_crawl(@create_attrs)
    crawl
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all crawls", %{conn: conn} do
      conn = get(conn, crawl_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create crawl" do
    @tag :skip
    test "renders crawl when data is valid", %{conn: conn} do
      conn = post(conn, crawl_path(conn, :create), crawl: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, crawl_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "cookie" => nil,
               "depth_limit" => 0,
               "pattern" => ".*",
               "recv_timeout" => 60000,
               "timeout" => 60000,
               "url" => "http://euros-test.blogspot.jp/"
             }
    end

    @tag :skip
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, crawl_path(conn, :create), crawl: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update crawl" do
    setup [:create_crawl]

    test "renders crawl when data is valid", %{conn: conn, crawl: %Crawl{id: id} = crawl} do
      conn = put(conn, crawl_path(conn, :update, crawl), crawl: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, crawl_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "cookie" => "some updated cookie",
               "depth_limit" => 43,
               "pattern" => "some updated pattern",
               "recv_timeout" => 43,
               "timeout" => 43,
               "url" => "http://euros-test.blogspot.jp/"
             }
    end

    test "renders errors when data is invalid", %{conn: conn, crawl: crawl} do
      conn = put(conn, crawl_path(conn, :update, crawl), crawl: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete crawl" do
    setup [:create_crawl]

    test "deletes chosen crawl", %{conn: conn, crawl: crawl} do
      conn = delete(conn, crawl_path(conn, :delete, crawl))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, crawl_path(conn, :show, crawl))
      end)
    end
  end

  defp create_crawl(_) do
    crawl = fixture(:crawl)
    {:ok, crawl: crawl}
  end
end
