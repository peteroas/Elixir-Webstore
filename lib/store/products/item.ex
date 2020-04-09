defmodule Store.Products.Item do
  use Ecto.Schema
  import Ecto.Changeset

  alias Store.Products.{Variant}

  schema "items" do
    field :brand, :string
    field :name, :string
    field :price, :integer

    has_many(:variants, Variant, on_delete: :delete_all)

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :brand, :price])
    |> validate_required([:name, :brand, :price])
  end
end
