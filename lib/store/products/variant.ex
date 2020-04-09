defmodule Store.Products.Variant do
  use Ecto.Schema
  import Ecto.Changeset

  alias Store.Products.{Item}

  schema "variants" do
    field :color, :string
    field :price, :integer
    field :size, :string

    belongs_to(:item, Item)

    timestamps()
  end

  @doc false
  def changeset(variant, attrs) do
    variant
    |> cast(attrs, [:price, :size, :color, :item_id])
    |> validate_required([:price, :size, :color, :item_id])
  end
end
