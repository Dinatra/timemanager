defmodule Timemachine.UserManager do
  @moduledoc """
  The UserManager context.
  """

  import Ecto.Query, warn: false

  alias Timemachine.Repo
  alias Timemachine.UserManager.User

  # [Get]
  def list_users, do: Repo.all(User)

  def get_user(id), do: Repo.get(User, id)

  def get_user_by_username(username), do: Repo.get_by(User, username: username)

  def search_user(username, email), do: Repo.get_by(User, username: username, email: email)

  # [Create/modify]
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user), do: Repo.delete(user)

  def change_user(%User{} = user, attrs \\ %{}), do: User.changeset(user, attrs)

  # [Auth]
  def authenticate_user(username, plain_text_password) do
    case get_user_by_username(username) do
      nil ->
        Bcrypt.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Bcrypt.verify_pass(plain_text_password, user.password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  def set_logout_time(user, date) do
    update_user(user, %{last_logout: date})
  end
end
