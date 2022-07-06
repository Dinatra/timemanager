defmodule TimemachineWeb.Plug.NoRevokeToken do
  import Plug.Conn

  alias TimemachineWeb.Auth

  def init(options), do: options

  def call(conn, _opts) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok, claim} <- Auth.Guardian.extract_claims(conn, "iat"),
         {:ok, emit_date} <- DateTime.from_unix(claim, :second) do
      if user.last_logout && emit_date < user.last_logout do
        conn
        |> send_resp(401, "Invalid token")
        |> halt()
      else
        conn
      end
    else
      _ -> conn
    end
  end
end
