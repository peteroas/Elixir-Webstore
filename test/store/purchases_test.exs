defmodule Store.PurchasesTest do
  use Store.DataCase

  alias Store.Purchases

  describe "orders" do
    alias Store.Purchases.Order

    @valid_attrs %{free_shipping: true}
    @update_attrs %{free_shipping: false}
    @invalid_attrs %{free_shipping: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Purchases.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Purchases.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Purchases.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Purchases.create_order(@valid_attrs)
      assert order.free_shipping == true
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Purchases.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Purchases.update_order(order, @update_attrs)
      assert order.free_shipping == false
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Purchases.update_order(order, @invalid_attrs)
      assert order == Purchases.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Purchases.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Purchases.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Purchases.change_order(order)
    end
  end
end
