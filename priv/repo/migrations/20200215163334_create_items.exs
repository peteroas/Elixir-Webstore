defmodule Store.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :brand, :string
      add :price, :integer

      timestamps()
    end

  end
end
