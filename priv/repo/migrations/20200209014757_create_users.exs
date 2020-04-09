defmodule Store.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :admin, :boolean, default: false, null: false
      add :password, :string

      timestamps()
    end

  end
end
