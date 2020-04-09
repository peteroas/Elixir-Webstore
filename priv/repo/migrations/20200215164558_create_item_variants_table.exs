defmodule Store.Repo.Migrations.CreateItemVariantsTable do
  use Ecto.Migration

  def change do
    alter table(:variants) do
      add :item_id, references(:items)
    end

    alter table(:orders) do
      add :user_id, references(:users)
    end

    create table(:orders_variants) do
      add :order_id, references(:orders)
      add :variant_id, references(:variants)
      add :quantity, :integer
    end
  end
end
