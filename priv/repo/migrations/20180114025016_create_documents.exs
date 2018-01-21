defmodule EurosServer.Repo.Migrations.CreateDocuments do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :url, :string
      add :body, :text
      add :crawl_id, references(:crawls, on_delete: :nothing)

      timestamps()
    end

    create index(:documents, [:crawl_id])
  end
end
