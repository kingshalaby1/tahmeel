defmodule Tahmeel.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :email, :string

      timestamps()
    end

  end
end
