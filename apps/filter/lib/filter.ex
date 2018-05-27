defmodule Filter do
  @moduledoc """
  Documentation for Filter.
  """
  alias Apartment.Facts

  @doc """
  Filter apartments.

  * `:max_rent`, find all apartments cheaper than the max rent.
  * `:rooms`, find all apartments with the correct number of rooms. Can also find all apartments with more than, or equal to, n rooms
  * `:types`, find all apartments of selected types.

  ## Example

      iex> all_apartments()
      iex> |> Filter.from_map(%{max_rent: 15000, rooms: {[2, 4], 8}, types: ["apartment"]})
      [
        %Apartment{
          facts: %Apartment.Facts{area: 86, rent: 9149, rooms: 4},
          type: :apartment,
          url: "https://www.boplatssyd.se/lagenhet/403854"
        },
        %Apartment{
          facts: %Apartment.Facts{area: 62, rent: 7951, rooms: 2},
          type: :apartment,
          url: "https://www.boplatssyd.se/lagenhet/404414"
        }
      ]
  """
  def from_map(apartments, map), do: Enum.reduce(map, apartments, &filter/2)

  defp filter({:max_rent, 0}, apartments), do: apartments

  defp filter({:max_rent, max_rent}, apartments),
    do: apartments
        |> Enum.filter(fn(%Apartment{facts: %Facts{rent: rent}}) -> rent <= max_rent end)

  defp filter({:rooms, {[], _max}}, apartments), do: apartments

  defp filter({:rooms, {values, max}}, apartments),
    do: apartments
        |> Enum.filter(fn(%Apartment{facts: %Facts{rooms: rooms}}) -> rooms in values || (max in values and rooms > max) end)

  defp filter({:types, []}, apartments), do: apartments

  defp filter({:types, types}, apartments),
    do: apartments
        |> Enum.filter(fn(%Apartment{type: type}) -> Atom.to_string(type) in types end)
end
