defmodule Tahmeel.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :weight, :decimal
      add :dropoff, references(:addresses, on_delete: :nothing)
      add :pickup, references(:addresses, on_delete: :nothing)
      add :client_id, references(:clients, on_delete: :nothing)

      timestamps()
    end

    create index(:orders, [:dropoff])
    create index(:orders, [:pickup])
    create index(:orders, [:client_id])
  end
end
