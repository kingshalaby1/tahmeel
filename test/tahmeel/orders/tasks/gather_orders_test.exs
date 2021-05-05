defmodule Tahmeel.Orders.Tasks.GatherOrdersTest do
  use Tahmeel.DataCase

  alias Tahmeel.Orders
  alias Tahmeel.Orders.Tasks.GatherOrders

  @yesterday NaiveDateTime.add(NaiveDateTime.utc_now(), -3600 * 24, :second) |> NaiveDateTime.truncate(:second)

  describe "GatherOrders task" do

    test "it collects order created yesterday" do

      c1 = Repo.insert!(%Orders.Client{email: "c1@mail.com"})

      address1 =
        Tahmeel.Repo.insert!(%Tahmeel.Orders.Address{
          line1: "some store address",
          city: "Dubai",
          state: "Dubai",
          country: "UAE",
          alias: "pickup point 1",
          client_id: c1.id
        })

      address2 =
        Tahmeel.Repo.insert!(%Tahmeel.Orders.Address{
          line1: "some customer's address",
          city: "Dubai",
          state: "Dubai",
          country: "UAE",
          client_id: c1.id
        })

      address3 =
        Tahmeel.Repo.insert!(%Tahmeel.Orders.Address{
          line1: "some other customer's address",
          city: "Abu Dhabi",
          state: "Abu Dhabi",
          country: "UAE",
          client_id: c1.id
        })

      _order1 =
        Tahmeel.Repo.insert!(%Tahmeel.Orders.Order{
          pickup: address1.id,
          dropoff: address2.id,
          weight: 1.5,
          client_id: c1.id,
          inserted_at: @yesterday
        })

      _order2 =
        Tahmeel.Repo.insert!(%Tahmeel.Orders.Order{
          pickup: address1.id,
          dropoff: address3.id,
          weight: 3.5,
          client_id: c1.id,
          inserted_at: @yesterday
        })

      expected_bulk = %{
        total_weight: 5.0,
        pickup_adresses: [address1.id],
        dropoff_adresses: [address3.id, address2.id]
      }



      actual_bulk = GatherOrders.run(DateTime.utc_now())
      assert expected_bulk.total_weight == actual_bulk.total_weight
      assert expected_bulk.pickup_adresses == actual_bulk.pickup_adresses
      assert expected_bulk.dropoff_adresses == actual_bulk.dropoff_adresses
    end

    test "it does not collect order created older than yesterday" do



      c1 = Repo.insert!(%Orders.Client{email: "c1@mail.com"})

      address1 =
        Tahmeel.Repo.insert!(%Tahmeel.Orders.Address{
          line1: "some store address",
          city: "Dubai",
          state: "Dubai",
          country: "UAE",
          alias: "pickup point 1",
          client_id: c1.id
        })

      address2 =
        Tahmeel.Repo.insert!(%Tahmeel.Orders.Address{
          line1: "some customer's address",
          city: "Dubai",
          state: "Dubai",
          country: "UAE",
          client_id: c1.id
        })

      _order1 =
        Tahmeel.Repo.insert!(%Tahmeel.Orders.Order{
          pickup: address1.id,
          dropoff: address2.id,
          weight: 1.5,
          client_id: c1.id,
          inserted_at: NaiveDateTime.new!(2021, 1, 1, 0, 0, 0)
        })

      expected_bulk = %{
        total_weight: 0,
        pickup_adresses: [],
        dropoff_adresses: []
      }



      actual_bulk = GatherOrders.run(DateTime.utc_now())
      assert expected_bulk.total_weight == actual_bulk.total_weight
      assert expected_bulk.pickup_adresses == actual_bulk.pickup_adresses
      assert expected_bulk.dropoff_adresses == actual_bulk.dropoff_adresses
    end

    test "it does not collect order created today" do



      c1 = Repo.insert!(%Orders.Client{email: "c1@mail.com"})

      address1 =
        Tahmeel.Repo.insert!(%Tahmeel.Orders.Address{
          line1: "some store address",
          city: "Dubai",
          state: "Dubai",
          country: "UAE",
          alias: "pickup point 1",
          client_id: c1.id
        })

      address2 =
        Tahmeel.Repo.insert!(%Tahmeel.Orders.Address{
          line1: "some customer's address",
          city: "Dubai",
          state: "Dubai",
          country: "UAE",
          client_id: c1.id
        })

      _order1 =
        Tahmeel.Repo.insert!(%Tahmeel.Orders.Order{
          pickup: address1.id,
          dropoff: address2.id,
          weight: 1.5,
          client_id: c1.id,
          inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
        })

      expected_bulk = %{
        total_weight: 0,
        pickup_adresses: [],
        dropoff_adresses: []
      }



      actual_bulk = GatherOrders.run(DateTime.utc_now())
      assert expected_bulk.total_weight == actual_bulk.total_weight
      assert expected_bulk.pickup_adresses == actual_bulk.pickup_adresses
      assert expected_bulk.dropoff_adresses == actual_bulk.dropoff_adresses
    end



  end


end
