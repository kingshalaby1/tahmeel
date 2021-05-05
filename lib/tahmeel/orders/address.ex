defmodule Tahmeel.Orders.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :alias, :string
    field :city, :string
    field :country, :string
    field :line1, :string
    field :line2, :string
    field :state, :string
    field :client_id, :id

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:line1, :line2, :city, :state, :country, :alias])
    |> validate_required([:line1, :line2, :city, :state, :country, :alias])
  end
end
