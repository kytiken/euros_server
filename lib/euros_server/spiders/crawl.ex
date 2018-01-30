defmodule EurosServer.Spiders.Crawl do
  use Ecto.Schema
  import Ecto.Changeset
  alias EurosServer.Spiders.Crawl

  schema "crawls" do
    field(:cookie, :string)
    field(:depth_limit, :integer)
    field(:pattern, :string)
    field(:recv_timeout, :integer)
    field(:timeout, :integer)
    field(:url, :string)
    has_many(:documents, EurosServer.Spiders.Document)

    timestamps()
  end

  @doc false
  def changeset(%Crawl{} = crawl, attrs) do
    crawl
    |> cast(attrs, [:url, :cookie, :recv_timeout, :timeout, :pattern, :depth_limit])
    |> validate_required([:url, :recv_timeout, :timeout])
  end

  def execute(
        %Crawl{
          id: id,
          url: url,
          timeout: timeout,
          recv_timeout: recv_timeout,
          pattern: pattern,
          depth_limit: depth_limit,
          cookie: cookie
        } = crawl
      ) do
    http_option = %Euros.HTTPOption{cookie: "", timeout: timeout, recv_timeout: recv_timeout}

    option = %Euros.CrawlOption{
      depth_limit: depth_limit,
      http_option: http_option,
      pattern: ~r/.*/
    }

    Euros.Core.crawl(
      url,
      fn page ->
        document_params = %{crawl_id: id, url: page.request_url, body: page.body}

        {:ok, %EurosServer.Spiders.Document{} = document} =
          EurosServer.Spiders.create_document(document_params)
      end,
      option
    )
  end
end
