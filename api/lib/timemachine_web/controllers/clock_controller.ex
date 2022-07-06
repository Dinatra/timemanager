defmodule TimemachineWeb.ClockController do
  use TimemachineWeb, :controller

  alias Timemachine.ClockManager
  alias Timemachine.ClockManager.Clock

  action_fallback TimemachineWeb.FallbackController

  def current_clock_me(conn, _) do
    user = Guardian.Plug.current_resource(conn)

    clock = ClockManager.get_current_clock(user.id)

    conn
    |> put_status(200)
    |> render("show.json", clock: clock)
  end

  def add_clock_me(conn, %{"clock" => %{"status" => status}}) do
    user = Guardian.Plug.current_resource(conn)
    prev_clock = ClockManager.get_current_clock(user.id)

    clock_params = %{
      status: status,
      time: DateTime.utc_now()
    }

    with {:ok, %Clock{} = clock} <- ClockManager.create_user_clocks(clock_params, user.id) do
      if prev_clock && prev_clock.status == status do
        conn
        |> send_resp(400, "! - Last clock have the same status")
      else
        conn
        |> put_status(:created)
        |> render("show.json", clock: clock)
      end
    end
  end
end
