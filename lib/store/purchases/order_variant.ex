defmodule Store.Purchases.OrderVariant do
  use Ecto.Schema
  import Ecto.Changeset

  alias Store.Products.{Item}
  alias Store.Purchases.{Order}

  schema "orders_variants" do
    belongs_to(:variant, Variant)
    belongs_to(:order, Order)

    timestamps()
  end

  @doc false
  def changeset(variant, attrs) do
    variant
    |> cast(attrs, [:order, :variant])
    |> validate_required([:order, :variant])
  end
end
