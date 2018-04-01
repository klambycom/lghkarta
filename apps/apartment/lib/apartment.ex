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

  @doc """
  Check if it is still possible to apply to this apartment.

  # Example

  Last day to apply is one day in the past:

      iex> %Apartment{last_date: Timex.subtract(Timex.now, Timex.Duration.from_days(1))}
      iex> |> Apartment.available?
      false

  Last day to apply is one day in the future:

      iex> %Apartment{last_date: Timex.add(Timex.now, Timex.Duration.from_days(1))}
      iex> |> Apartment.available?
      true
  """
  def available?(%__MODULE__{last_date: last_date}), do: Timex.before?(Timex.now, last_date)
end
