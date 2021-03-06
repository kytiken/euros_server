defmodule EurosServer.SpidersTest do
  use EurosServer.DataCase

  alias EurosServer.Spiders

  describe "crawls" do
    alias EurosServer.Spiders.Crawl

    @valid_attrs %{
      cookie: "some cookie",
      depth_limit: 42,
      pattern: "some pattern",
      recv_timeout: 42,
      timeout: 42,
      url: "some url"
    }
    @update_attrs %{
      cookie: "some updated cookie",
      depth_limit: 43,
      pattern: "some updated pattern",
      recv_timeout: 43,
      timeout: 43,
      url: "some updated url"
    }
    @invalid_attrs %{
      cookie: nil,
      depth_limit: nil,
      pattern: nil,
      recv_timeout: nil,
      timeout: nil,
      url: nil
    }

    def crawl_fixture(attrs \\ %{}) do
      {:ok, crawl} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Spiders.create_crawl()

      crawl
    end

    test "list_crawls/0 returns all crawls" do
      crawl = crawl_fixture()
      assert Spiders.list_crawls() == [crawl]
    end

    test "get_crawl!/1 returns the crawl with given id" do
      crawl = crawl_fixture()
      assert Spiders.get_crawl!(crawl.id) == crawl
    end

    test "create_crawl/1 with valid data creates a crawl" do
      assert {:ok, %Crawl{} = crawl} = Spiders.create_crawl(@valid_attrs)
      assert crawl.cookie == "some cookie"
      assert crawl.depth_limit == 42
      assert crawl.pattern == "some pattern"
      assert crawl.recv_timeout == 42
      assert crawl.timeout == 42
      assert crawl.url == "some url"
    end

    test "create_crawl/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Spiders.create_crawl(@invalid_attrs)
    end

    test "update_crawl/2 with valid data updates the crawl" do
      crawl = crawl_fixture()
      assert {:ok, crawl} = Spiders.update_crawl(crawl, @update_attrs)
      assert %Crawl{} = crawl
      assert crawl.cookie == "some updated cookie"
      assert crawl.depth_limit == 43
      assert crawl.pattern == "some updated pattern"
      assert crawl.recv_timeout == 43
      assert crawl.timeout == 43
      assert crawl.url == "some updated url"
    end

    test "update_crawl/2 with invalid data returns error changeset" do
      crawl = crawl_fixture()
      assert {:error, %Ecto.Changeset{}} = Spiders.update_crawl(crawl, @invalid_attrs)
      assert crawl == Spiders.get_crawl!(crawl.id)
    end

    test "delete_crawl/1 deletes the crawl" do
      crawl = crawl_fixture()
      assert {:ok, %Crawl{}} = Spiders.delete_crawl(crawl)
      assert_raise Ecto.NoResultsError, fn -> Spiders.get_crawl!(crawl.id) end
    end

    test "change_crawl/1 returns a crawl changeset" do
      crawl = crawl_fixture()
      assert %Ecto.Changeset{} = Spiders.change_crawl(crawl)
    end
  end

  describe "documents" do
    alias EurosServer.Spiders.Document

    @valid_attrs %{body: "some body", url: "some url", crawl_id: nil}
    @update_attrs %{body: "some updated body", url: "some updated url", crawl_id: nil}
    @invalid_attrs %{body: nil, url: nil, crawl_id: nil}

    def document_fixture(attrs \\ %{}) do
      crawl = crawl_fixture()

      {:ok, document} =
        attrs
        |> Enum.into(%{@valid_attrs | crawl_id: crawl.id})
        |> Spiders.create_document()

      document
    end

    test "list_documents/0 returns all documents" do
      document = document_fixture()
      assert Spiders.list_documents() == [document]
    end

    test "get_document!/1 returns the document with given id" do
      document = document_fixture()
      assert Spiders.get_document!(document.id) == document
    end

    test "create_document/1 with valid data creates a document" do
      crawl = crawl_fixture()

      assert {:ok, %Document{} = document} =
               Spiders.create_document(%{@valid_attrs | crawl_id: crawl.id})

      assert document.body == "some body"
      assert document.url == "some url"
    end

    test "create_document/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Spiders.create_document(@invalid_attrs)
    end

    test "update_document/2 with valid data updates the document" do
      document = document_fixture()
      crawl = crawl_fixture()

      assert {:ok, document} =
               Spiders.update_document(document, %{@update_attrs | crawl_id: crawl.id})

      assert %Document{} = document
      assert document.body == "some updated body"
      assert document.url == "some updated url"
    end

    test "update_document/2 with invalid data returns error changeset" do
      document = document_fixture()
      assert {:error, %Ecto.Changeset{}} = Spiders.update_document(document, @invalid_attrs)
      assert document == Spiders.get_document!(document.id)
    end

    test "delete_document/1 deletes the document" do
      document = document_fixture()
      assert {:ok, %Document{}} = Spiders.delete_document(document)
      assert_raise Ecto.NoResultsError, fn -> Spiders.get_document!(document.id) end
    end

    test "change_document/1 returns a document changeset" do
      document = document_fixture()
      assert %Ecto.Changeset{} = Spiders.change_document(document)
    end
  end
end
