defmodule Tahmeel.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :weight, :decimal
    field :dropoff, :id
    field :pickup, :id
    field :client_id, :id

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:weight])
    |> validate_required([:weight])
  end
end
