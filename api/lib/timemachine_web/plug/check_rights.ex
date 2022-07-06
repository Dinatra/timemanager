defmodule TimemachineWeb.Plug.CheckRights do
  import Plug.Conn

  def init(options), do: options

  def call(conn, opts) do
    user = Guardian.Plug.current_resource(conn)

    if !user.role ||
         user_has_role(user, opts[:roles]) == false do
      conn
      |> send_resp(403, "Not allowed")
      |> halt()
    else
      conn
    end
  end

  defp user_has_role(user, list) do
    to_string(user.role) in list == true
  end
end
