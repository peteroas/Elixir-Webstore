defmodule StoreWeb.VariantController do
  use StoreWeb, :controller

  alias Store.Products
  alias Store.Products.Variant

  def index(conn, _params) do
    variants = Products.list_variants([:item])
    render(conn, "index.html", variants: variants)
  end

  def new(conn, _params) do
    items = Products.list_items()
    changeset = Products.change_variant(%Variant{})
    render(conn, "new.html", changeset: changeset, items: items)
  end

  def create(conn, %{"variant" => variant_params}) do
    case Products.create_variant(variant_params) do
      {:ok, variant} ->
        conn
        |> put_flash(:info, "Variant created successfully.")
        |> redirect(to: Routes.variant_path(conn, :show, variant))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, items: Products.list_items())
    end
  end

  def show(conn, %{"id" => id}) do
    variant = Products.get_variant!(id)
    render(conn, "show.html", variant: variant)
  end

  def edit(conn, %{"id" => id}) do
    variant = Products.get_variant!(id)
    changeset = Products.change_variant(variant)
    render(conn, "edit.html", variant: variant, changeset: changeset)
  end

  def update(conn, %{"id" => id, "variant" => variant_params}) do
    variant = Products.get_variant!(id)

    case Products.update_variant(variant, variant_params) do
      {:ok, variant} ->
        conn
        |> put_flash(:info, "Variant updated successfully.")
        |> redirect(to: Routes.variant_path(conn, :show, variant))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", variant: variant, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    variant = Products.get_variant!(id)
    {:ok, _variant} = Products.delete_variant(variant)

    conn
    |> put_flash(:info, "Variant deleted successfully.")
    |> redirect(to: Routes.variant_path(conn, :index))
  end
end
