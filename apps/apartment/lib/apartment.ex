defmodule Apartment do
  @moduledoc """
  Documentation for Apartment.
  """
  alias Apartment.{Server, History, Facts, Address}

  defstruct id: nil, url: nil, last_date: nil, available_date: nil, type: nil, facts: %Facts{}, address: %Address{}

  @doc """
  Save apartment.
  """
  def save(%__MODULE__{} = apartment) do
    GenServer.cast(Server, {:add, apartment})
    History.save(apartment)

    :ok
  end

  @doc """
  Get apartment by id.

  Will first try to find available apartment, and then try to find the apartment
  in the historical data if it can't be found.
  """
  def by_id(id) do
    case GenServer.call(Server, {:by_id, id}) do
      nil -> History.by_id(id)
      item -> item
    end
  end

  @doc """
  Get all available apartments.
  """
  def all, do: GenServer.call(Server, :all)
end
