defmodule Store.Purchases.Order do
  use Ecto.Schema
  import Ecto.Changeset

  alias Store.Accounts.User
  alias Store.Products.{Variant}
  alias Store.Purchases.{OrderVariant}

  schema "orders" do
    field :free_shipping, :boolean, default: false

    belongs_to(:user, User)

    many_to_many(:variant_items, Variant,
      join_through: OrderVariant,
      on_delete: :delete_all,
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:free_shipping])
    |> validate_required([:free_shipping])
  end
end
