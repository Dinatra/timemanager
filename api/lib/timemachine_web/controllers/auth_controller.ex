defmodule TimemachineWeb.AuthController do
  use TimemachineWeb, :controller

  alias Timemachine.UserManager
  alias TimemachineWeb.Auth

  action_fallback TimemachineWeb.FallbackController

  def login(conn, %{"user" => %{"username" => username, "password" => password}}) do
    with {:ok, user} <- UserManager.authenticate_user(username, password),
         csrf_token <- Plug.CSRFProtection.get_csrf_token() do
      conn
      |> Auth.Guardian.Plug.remember_me(user, %{
        csrf: csrf_token
      })
      |> render("login.json", csrf: csrf_token, user: user)
    else
      {:error, reason} ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(401, to_string(reason))
    end
  end

  def logout(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    date = DateTime.utc_now()

    UserManager.set_logout_time(user, date)

    conn
    |> Auth.Guardian.Plug.clear_remember_me()
    |> send_resp(200, to_string(date))
  end
end
