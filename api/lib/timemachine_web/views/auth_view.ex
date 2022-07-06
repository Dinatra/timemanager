defmodule TimemachineWeb.AuthView do
  use TimemachineWeb, :view

  def render("login.json", %{csrf: csrf, user: user}) do
    %{
      csrf_token: csrf,
      user: %{
        id: user.id,
        username: user.username,
        email: user.email,
        role: user.role
      }
    }
  end
end
