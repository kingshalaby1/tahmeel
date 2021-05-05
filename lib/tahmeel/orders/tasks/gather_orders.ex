defmodule Tahmeel.Orders.Tasks.GatherOrders do
  @moduledoc """
    gathering all orders that have been created in specific day.
    to be used periodically every midnight by Quantum.
  """

  import Ecto.Query, warn: false
  alias Tahmeel.Repo
  alias Tahmeel.Orders.Order
  use Timex

  #  @spec prepare_bulk_orders(DateTime.t()) :: %{total_weight: number(), orders: [Order.t()]}
  def run(time) do
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
#        IO.inspect(pickup, label: "pickups>>>")
#        IO.inspect(dropoff, label: "dropoff>>>")
        {weight + w, [pickup | pickups], [dropoff | dropoffs]}
      end)

#         IO.inspect(pickups, label: "pickups>>>")
#    IO.inspect(dropoffs, label: "dropoffs>>>")
    %{
      reference: Ecto.UUID.generate(),
      total_weight: total_weight,
      pickup_adresses: Enum.uniq(pickups),
      dropoff_adresses: Enum.uniq(dropoffs)
    }
  end
end
