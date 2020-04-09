defmodule StoreWeb.VariantControllerTest do
  use StoreWeb.ConnCase

  alias Store.Products

  @create_attrs %{color: "some color", price: 42, size: "some size"}
  @update_attrs %{color: "some updated color", price: 43, size: "some updated size"}
  @invalid_attrs %{color: nil, price: nil, size: nil}

  def fixture(:variant) do
    {:ok, variant} = Products.create_variant(@create_attrs)
    variant
  end

  describe "index" do
    test "lists all variants", %{conn: conn} do
      conn = get(conn, Routes.variant_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Variants"
    end
  end

  describe "new variant" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.variant_path(conn, :new))
      assert html_response(conn, 200) =~ "New Variant"
    end
  end

  describe "create variant" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.variant_path(conn, :create), variant: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.variant_path(conn, :show, id)

      conn = get(conn, Routes.variant_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Variant"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.variant_path(conn, :create), variant: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Variant"
    end
  end

  describe "edit variant" do
    setup [:create_variant]

    test "renders form for editing chosen variant", %{conn: conn, variant: variant} do
      conn = get(conn, Routes.variant_path(conn, :edit, variant))
      assert html_response(conn, 200) =~ "Edit Variant"
    end
  end

  describe "update variant" do
    setup [:create_variant]

    test "redirects when data is valid", %{conn: conn, variant: variant} do
      conn = put(conn, Routes.variant_path(conn, :update, variant), variant: @update_attrs)
      assert redirected_to(conn) == Routes.variant_path(conn, :show, variant)

      conn = get(conn, Routes.variant_path(conn, :show, variant))
      assert html_response(conn, 200) =~ "some updated color"
    end

    test "renders errors when data is invalid", %{conn: conn, variant: variant} do
      conn = put(conn, Routes.variant_path(conn, :update, variant), variant: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Variant"
    end
  end

  describe "delete variant" do
    setup [:create_variant]

    test "deletes chosen variant", %{conn: conn, variant: variant} do
      conn = delete(conn, Routes.variant_path(conn, :delete, variant))
      assert redirected_to(conn) == Routes.variant_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.variant_path(conn, :show, variant))
      end
    end
  end

  defp create_variant(_) do
    variant = fixture(:variant)
    {:ok, variant: variant}
  end
end
