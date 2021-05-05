defmodule Tahmeel.OrdersTest do
  use Tahmeel.DataCase

  alias Tahmeel.Orders

  describe "clients" do
    alias Tahmeel.Orders.Client

    @valid_attrs %{email: "some email"}
    @update_attrs %{email: "some updated email"}
    @invalid_attrs %{email: nil}

    def client_fixture(attrs \\ %{}) do
      {:ok, client} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Orders.create_client()

      client
    end

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert Orders.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert Orders.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      assert {:ok, %Client{} = client} = Orders.create_client(@valid_attrs)
      assert client.email == "some email"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      assert {:ok, %Client{} = client} = Orders.update_client(client, @update_attrs)
      assert client.email == "some updated email"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_client(client, @invalid_attrs)
      assert client == Orders.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = Orders.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = Orders.change_client(client)
    end
  end
end
