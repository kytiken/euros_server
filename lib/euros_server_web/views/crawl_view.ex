defmodule EurosServerWeb.CrawlView do
  use EurosServerWeb, :view
  alias EurosServerWeb.CrawlView

  def render("index.json", %{crawls: crawls}) do
    %{data: render_many(crawls, CrawlView, "crawl.json")}
  end

  def render("show.json", %{crawl: crawl}) do
    %{data: render_one(crawl, CrawlView, "crawl.json")}
  end

  def render("crawl.json", %{crawl: crawl}) do
    %{
      id: crawl.id,
      url: crawl.url,
      cookie: crawl.cookie,
      recv_timeout: crawl.recv_timeout,
      timeout: crawl.timeout,
      pattern: crawl.pattern,
      depth_limit: crawl.depth_limit
    }
  end
end
