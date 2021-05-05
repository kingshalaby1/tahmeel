# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tahmeel.Repo.insert!(%Tahmeel.SomeSchema{})


c1 = Tahmeel.Repo.insert!(%Tahmeel.Orders.Client{email: "c1@mail.com"})
_c2 = Tahmeel.Repo.insert!(%Tahmeel.Orders.Client{email: "c2@mail.com"})

add1 = Tahmeel.Repo.insert!(%Tahmeel.Orders.Address{line1: "some store address", city: "Dubai", state: "Dubai", country: "UAE", alias: "pickup point 1", client_id: c1.id})
add2 = Tahmeel.Repo.insert!(%Tahmeel.Orders.Address{line1: "some customer's address", city: "Dubai", state: "Dubai", country: "UAE", client_id: c1.id})
add3 = Tahmeel.Repo.insert!(%Tahmeel.Orders.Address{line1: "some other customer's address", city: "Dubai", state: "Dubai", country: "UAE", client_id: c1.id})

_o1 = Tahmeel.Repo.insert!(%Tahmeel.Orders.Order{pickup: add1.id, dropoff: add2.id, weight: 1.5, client_id: c1.id})
_o2 = Tahmeel.Repo.insert!(%Tahmeel.Orders.Order{pickup: add1.id, dropoff: add3.id, weight: 6, client_id: c1.id})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
