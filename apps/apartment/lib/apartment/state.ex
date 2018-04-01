defmodule Apartment.State do
  defstruct items: %{}

  @doc """
  Create a new `%State{}` from a list of items.

  # Example

      iex> [
      ...>   %{id: 1},
      ...>   %{id: 2},
      ...>   %{id: 3}
      ...> ]
      iex> |> State.from_list
      %State{
        items: %{
          1 => %{id: 1},
          2 => %{id: 2},
          3 => %{id: 3}
        }
      }
  """
  def from_list(items) do
    %__MODULE__{
      items: Enum.reduce(items, %{}, fn (item, acc) -> Map.put(acc, item.id, item) end)
    }
  end

  @doc """
  Add new item to the state.

  # Example

      iex> %State{}
      iex> |> State.add(%{id: 1})
      %State{
        items: %{1 => %{id: 1}}
      }
  """
  def add(state, item) do
    %{state | items: Map.put(state.items, item.id, item)}
  end

  @doc """
  Find item by id.

  # Example

      iex> %State{
      ...>   items: %{
      ...>     1 => %{id: 1},
      ...>     2 => %{id: 2},
      ...>     3 => %{id: 3}
      ...>   }
      ...> }
      iex> |> State.by_id(2)
      %{id: 2}
  """
  def by_id(state, id), do: Map.get(state.items, id)

  @doc """
  Remove all expired ads.

  # Example

      iex> fresh_state =
      iex>   %State{
      ...>     items: %{
      ...>       1 => %Apartment{id: 1, last_date: Timex.add(Timex.now, Timex.Duration.from_days(1))},
      ...>       2 => %Apartment{id: 2, last_date: Timex.subtract(Timex.now, Timex.Duration.from_days(1))},
      ...>       3 => %Apartment{id: 3, last_date: Timex.add(Timex.now, Timex.Duration.from_days(1))}
      ...>     }
      ...>   }
      iex>   |> State.remove_expired
      iex>
      iex> length(Map.to_list(fresh_state.items))
      2
  """
  def remove_expired(state),
    do: %{state | items: filter(state.items, &Apartment.available?/1)}

  defp filter(items, fun),
    do: Enum.filter(items, fn {_id, apartment} -> fun.(apartment) end)
        |> Enum.into(%{})
end
