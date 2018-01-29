defmodule EurosServer.Spiders.Document do
  use Ecto.Schema
  import Ecto.Changeset
  alias EurosServer.Spiders.Document


  schema "documents" do
    field :body, :string
    field :url, :string
    field :crawl_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Document{} = document, attrs) do
    document
    |> cast(attrs, [:url, :body, :crawl_id])
    |> validate_required([:url, :body, :crawl_id])
  end
end
