defmodule PhoenixApiTemplate.Profiles.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "profiles" do
    field(:display_name, :string)
    belongs_to(:user, PhoenixApiTemplate.Accounts.User)

    timestamps()
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:display_name, :user_id])
    |> validate_required([:display_name, :user_id])
  end
end
