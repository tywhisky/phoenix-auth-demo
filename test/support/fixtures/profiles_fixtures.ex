defmodule PhoenixApiTemplate.ProfilesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixApiTemplate.Profiles` context.
  """

  @doc """
  Generate a profile.
  """
  def profile_fixture(attrs \\ %{}) do
    {:ok, profile} =
      attrs
      |> Enum.into(%{
        display_name: "some display_name"
      })
      |> PhoenixApiTemplate.Profiles.create_profile()

    profile
  end
end
