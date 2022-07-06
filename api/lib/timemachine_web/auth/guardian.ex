defmodule TimemachineWeb.Auth.Guardian do
  use Guardian, otp_app: :timemachine

  alias Timemachine.UserManager

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = UserManager.get_user(id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end

  def extract_claims(conn, claim) do
    try do
      claims = Enum.into(Guardian.Plug.current_claims(conn), %{})
      {:ok, claims[claim]}
    rescue
      e -> {:error, e}
    end
  end
end
