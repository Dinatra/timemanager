defmodule Timemachine.WorkingtimeManager do
  @moduledoc """
  The WorkingtimeManager context.
  """

  import Ecto.Query, warn: false
  alias Timemachine.Repo

  alias Timemachine.WorkingtimeManager.Workingtime
  alias Timemachine.TeamManager.UserTeam

  # [Basic]

  @doc """
  Return:
    -> [%Workingtime{}, ...]
  """
  def list_workingtimes do
    Repo.all(Workingtime)
  end

  @doc """
  Return:
    -> %Workingtime{}
  Raise:
    ->  ** (Ecto.NoResultsError)
  """
  def get_workingtime!(id), do: Repo.get!(Workingtime, id)

  @doc """
  Return:
    -> {:ok, %Workingtime{}}
    -> {:error, %Ecto.Changeset{}}
  """
  def create_workingtime(attrs \\ %{}) do
    %Workingtime{}
    |> Workingtime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Return:
    -> {:ok, %Workingtime{}}
    -> {:error, %Ecto.Changeset{}}
  """
  def update_workingtime(%Workingtime{} = workingtime, attrs) do
    workingtime
    |> Workingtime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Return:
    -> {:ok, %Workingtime{}}
    -> {:error, %Ecto.Changeset{}}
  """
  def delete_workingtime(%Workingtime{} = workingtime) do
    Repo.delete(workingtime)
  end

  @doc """
  Return:
    -> `%Ecto.Changeset{}`
  """
  def change_workingtime(%Workingtime{} = workingtime, attrs \\ %{}) do
    Workingtime.changeset(workingtime, attrs)
  end

  # [Custom]

  def search_workingtime(userId, startSearch, endSearch) do
    Repo.all(
      from(w in Workingtime,
        where: w.user_id == ^userId and ^startSearch < w.end and w.start < ^endSearch
      )
    )
  end

  def create_user_workingtime(attrs \\ %{}, id) do
    %Workingtime{user_id: id}
    |> Workingtime.changeset(attrs)
    |> Repo.insert()
  end

  def get_all_workingtime_of_user_of_team(teamID) do
    query =
      from ut in UserTeam,
        join: w in Workingtime,
        on: ut.user_id == w.user_id,
        where: ut.team_id == ^teamID

    query =
      from [ut, w] in query,
        select: {w}

    Repo.all(query)
  end

  def get_all_workingtime_of_user_of_team_user(teamID, userID) do
    query =
      from ut in UserTeam,
        join: w in Workingtime,
        on: ut.user_id == w.user_id,
        where: ut.team_id == ^teamID and ut.user_id == ^userID

    query =
      from [ut, w] in query,
        select: {w}

    Repo.all(query)
  end
end
