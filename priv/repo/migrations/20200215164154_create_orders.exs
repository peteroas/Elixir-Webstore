defmodule Store.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :free_shipping, :boolean, default: false, null: false

      timestamps()
    end

  end
end
