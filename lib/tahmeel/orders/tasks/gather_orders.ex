defmodule Tahmeel.Orders.Tasks.GatherOrders do
  @moduledoc """
    gathering all orders that have been created in specific day.
    to be used periodically every midnight by Quantum.
  """

  import Ecto.Query, warn: false
  alias Tahmeel.Repo
  alias Tahmeel.Orders.Order
  use Timex

  def run(), do: prepare_bulk_orders(DateTime.utc_now())

  def prepare_bulk_orders(time) do
    from =
      time
      |> Timex.subtract(Duration.from_days(1))
      |> Timex.beginning_of_day()

    to = Timex.end_of_day(from)

    from(o in Order,
      where: o.inserted_at >= ^from,
      where: o.inserted_at <= ^to
    )
    |> Repo.all()
    |> aggregate_bulk_orders()
  end

  defp aggregate_bulk_orders(orders) do
    {total_weight, pickups, dropoffs} =
      Enum.reduce(orders, {0, [], []}, fn %{weight: w, pickup: pickup, dropoff: dropoff},
                                          {weight, pickups, dropoffs} ->
        {weight + w, [pickup | pickups], [dropoff | dropoffs]}
      end)

    %{
      reference: Ecto.UUID.generate(),
      total_weight: total_weight,
      pickup_adresses: Enum.uniq(pickups),
      dropoff_adresses: Enum.uniq(dropoffs)
    }
  end
end
