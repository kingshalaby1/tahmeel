defmodule Tahmeel.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :line1, :text
      add :line2, :text
      add :city, :string
      add :state, :string
      add :country, :string
      add :alias, :string
      add :client_id, references(:clients, on_delete: :nothing)

      timestamps()
    end

    create index(:addresses, [:client_id])
  end
end
