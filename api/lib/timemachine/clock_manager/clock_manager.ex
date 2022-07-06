defmodule Timemachine.ClockManager do
  @moduledoc """
  The ClockManager context.
  """

  import Ecto.Query, warn: false
  alias Timemachine.Repo

  alias Timemachine.ClockManager.Clock

  # [Basic]

  @doc """
  Return:
    -> [%Clock{}, ...]
  """
  def list_clocks do
    Repo.all(Clock)
  end

  @doc """
  Return:
    -> %Clock{}
  Raise:
    ->  ** (Ecto.NoResultsError)
  """
  def get_clock!(id), do: Repo.get!(Clock, id)

  @doc """
  Return:
    -> {:ok, %Clock{}}
    -> {:error, %Ecto.Changeset{}}
  """
  def create_clock(attrs \\ %{}) do
    %Clock{}
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Return:
    -> {:ok, %Clock{}}
    -> {:error, %Ecto.Changeset{}}
  """
  def update_clock(%Clock{} = clock, attrs) do
    clock
    |> Clock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Return:
    -> {:ok, %Clock{}}
    -> {:error, %Ecto.Changeset{}}
  """
  def delete_clock(%Clock{} = clock) do
    Repo.delete(clock)
  end

  @doc """
  Return:
    -> `%Ecto.Changeset{}`
  """
  def change_clock(%Clock{} = clock, attrs \\ %{}) do
    Clock.changeset(clock, attrs)
  end

  # [Custom]

  @doc """
  Return:
    -> [%Clock{}, ...]
  """
  def list_user_clocks!(userID) do
    Repo.all(from(c in Clock, where: c.user_id == ^userID))
  end

  def get_current_clock(userID) do
    Repo.one(from(c in Clock, order_by: [desc: c.time], limit: 1, where: c.user_id == ^userID))
  end

  @doc """
  Return:
    -> {:ok, %Clock{}}
    -> {:error, %Ecto.Changeset{}}
  """
  def create_user_clocks(attrs \\ %{}, id) do
    %Clock{user_id: id}
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end
end
