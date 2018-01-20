defmodule EurosServer.Spiders.Crawl do
  use Ecto.Schema
  import Ecto.Changeset
  alias EurosServer.Spiders.Crawl


  schema "crawls" do
    field :cookie, :string
    field :depth_limit, :integer
    field :pattern, :string
    field :recv_timeout, :integer
    field :timeout, :integer
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(%Crawl{} = crawl, attrs) do
    crawl
    |> cast(attrs, [:url, :cookie, :recv_timeout, :timeout, :pattern, :depth_limit])
    |> validate_required([:url, :recv_timeout, :timeout])
  end
end
