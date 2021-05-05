defmodule Tahmeel.Orders.Client do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clients" do
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:email])
    |> validate_required([:email])
  end
end
