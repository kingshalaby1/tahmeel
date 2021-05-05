defmodule Tahmeel.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  schema "orders" do
    field :weight, :float
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
