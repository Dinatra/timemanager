defmodule TimemachineWeb.Plug.SkipPermission do
  import Plug.Conn

  def init(options), do: options

  def call(conn, opts) do
    user = Guardian.Plug.current_resource(conn)

    header_value = Plug.Conn.fetch_query_params(conn).query_params[opts[:header_key]]
    user_value = user[opts[:user_key]]

    if user_value && header_value && user_value == header_value do
      assign(conn, :skip_permision, true)
    else
      conn
    end
  end
end
