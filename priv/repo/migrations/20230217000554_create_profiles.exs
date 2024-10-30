defmodule PhoenixApiTemplate.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:display_name, :string)
      add(:user_id, references(:users, on_delete: :delete_all, type: :binary_id))

      timestamps()
    end

    create(index(:profiles, [:user_id, :display_name]))
  end
end
