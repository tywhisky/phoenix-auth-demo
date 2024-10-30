defmodule PhoenixApiTemplateWeb.ProfileView do
  use PhoenixApiTemplateWeb, :view
  alias PhoenixApiTemplateWeb.ProfileView

  def render("index.json", %{profiles: profiles}) do
    %{data: render_many(profiles, ProfileView, "profile.json")}
  end

  def render("show.json", %{profile: profile}) do
    %{data: render_one(profile, ProfileView, "profile.json")}
  end

  def render("profile.json", %{profile: profile}) do
    %{
      id: profile.id,
      display_name: profile.display_name
    }
  end
end
