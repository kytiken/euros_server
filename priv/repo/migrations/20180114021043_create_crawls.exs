defmodule EurosServer.Repo.Migrations.CreateCrawls do
  use Ecto.Migration

  def change do
    create table(:crawls) do
      add :url, :string
      add :cookie, :string
      add :recv_timeout, :integer
      add :timeout, :integer
      add :pattern, :string
      add :depth_limit, :integer

      timestamps()
    end

  end
end
