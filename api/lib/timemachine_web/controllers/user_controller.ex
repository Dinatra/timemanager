defmodule TimemachineWeb.UserController do
  use TimemachineWeb, :controller

  alias TimemachineWeb.Auth
  alias Timemachine.UserManager
  alias Timemachine.UserManager.User

  action_fallback TimemachineWeb.FallbackController

  def create(conn, %{
        "user" => %{"username" => username, "password" => password, "email" => email}
      }) do
    user_params = %{
      username: username,
      password: password,
      email: email
    }

    with {:ok, %User{} = user} <- UserManager.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def show_me(conn, _) do
    user = Guardian.Plug.current_resource(conn)

    render(conn, "show.json", user: user)
  end

  def update_me(conn, %{
        "user" => user_params
      }) do
    user = Guardian.Plug.current_resource(conn)

    user_params = Map.put(user_params, "role", user.role)
    IO.inspect(user_params)

    with {:ok, %User{} = user} <- UserManager.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete_me(conn, _) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok, %User{}} <- UserManager.delete_user(user) do
      conn
      |> Auth.Guardian.Plug.clear_remember_me()
      |> send_resp(200, "Delete complete.")
    end
  end
end
