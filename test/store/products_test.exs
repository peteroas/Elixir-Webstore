defmodule Store.ProductsTest do
  use Store.DataCase

  alias Store.Products

  describe "items" do
    alias Store.Products.Item

    @valid_attrs %{brand: "some brand", name: "some name", price: 42}
    @update_attrs %{brand: "some updated brand", name: "some updated name", price: 43}
    @invalid_attrs %{brand: nil, name: nil, price: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Products.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Products.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Products.create_item(@valid_attrs)
      assert item.brand == "some brand"
      assert item.name == "some name"
      assert item.price == 42
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, %Item{} = item} = Products.update_item(item, @update_attrs)
      assert item.brand == "some updated brand"
      assert item.name == "some updated name"
      assert item.price == 43
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_item(item, @invalid_attrs)
      assert item == Products.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Products.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Products.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Products.change_item(item)
    end
  end

  describe "variants" do
    alias Store.Products.Variant

    @valid_attrs %{color: "some color", price: 42, size: "some size"}
    @update_attrs %{color: "some updated color", price: 43, size: "some updated size"}
    @invalid_attrs %{color: nil, price: nil, size: nil}

    def variant_fixture(attrs \\ %{}) do
      {:ok, variant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_variant()

      variant
    end

    test "list_variants/0 returns all variants" do
      variant = variant_fixture()
      assert Products.list_variants() == [variant]
    end

    test "get_variant!/1 returns the variant with given id" do
      variant = variant_fixture()
      assert Products.get_variant!(variant.id) == variant
    end

    test "create_variant/1 with valid data creates a variant" do
      assert {:ok, %Variant{} = variant} = Products.create_variant(@valid_attrs)
      assert variant.color == "some color"
      assert variant.price == 42
      assert variant.size == "some size"
    end

    test "create_variant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_variant(@invalid_attrs)
    end

    test "update_variant/2 with valid data updates the variant" do
      variant = variant_fixture()
      assert {:ok, %Variant{} = variant} = Products.update_variant(variant, @update_attrs)
      assert variant.color == "some updated color"
      assert variant.price == 43
      assert variant.size == "some updated size"
    end

    test "update_variant/2 with invalid data returns error changeset" do
      variant = variant_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_variant(variant, @invalid_attrs)
      assert variant == Products.get_variant!(variant.id)
    end

    test "delete_variant/1 deletes the variant" do
      variant = variant_fixture()
      assert {:ok, %Variant{}} = Products.delete_variant(variant)
      assert_raise Ecto.NoResultsError, fn -> Products.get_variant!(variant.id) end
    end

    test "change_variant/1 returns a variant changeset" do
      variant = variant_fixture()
      assert %Ecto.Changeset{} = Products.change_variant(variant)
    end
  end
end
