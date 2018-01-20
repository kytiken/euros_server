defmodule EurosServer.SpidersTest do
  use EurosServer.DataCase

  alias EurosServer.Spiders

  describe "crawls" do
    alias EurosServer.Spiders.Crawl

    @valid_attrs %{cookie: "some cookie", depth_limit: 42, pattern: "some pattern", recv_timeout: 42, timeout: 42, url: "some url"}
    @update_attrs %{cookie: "some updated cookie", depth_limit: 43, pattern: "some updated pattern", recv_timeout: 43, timeout: 43, url: "some updated url"}
    @invalid_attrs %{cookie: nil, depth_limit: nil, pattern: nil, recv_timeout: nil, timeout: nil, url: nil}

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
end
