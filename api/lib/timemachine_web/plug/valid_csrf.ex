defmodule TimemachineWeb.Plug.ValidCsrf do
  import Plug.Conn

  alias TimemachineWeb.Auth

  def init(options), do: options

  def call(conn, _opts) do
    with {:ok, claim} <- Auth.Guardian.extract_claims(conn, "csrf") do
      if claim != List.first(get_req_header(conn, "xcsrf")) do
        conn
        |> send_resp(401, "Invalid csrf token")
        |> halt()
      end
    else
      _ ->
        conn
        |> send_resp(401, "Invalid token")
        |> halt()
    end

    conn
  end
end
