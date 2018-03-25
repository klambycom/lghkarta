defmodule Apartment.Cache do
  use GenServer
  alias Apartment.{State, Persistent}

  def write(key, item), do: :ets.insert(__MODULE__, {key, item})

  def read(key, default \\ nil) do
    case :ets.lookup(__MODULE__, key) do
      [{_key, item}] -> item
      [] -> default
    end
  end

  #def write(item), do: :ets.insert(__MODULE__, {item.id, item})

  #def by_id(id) do
  #  case :ets.lookup(__MODULE__, id) do
  #    [{_id, item}] -> item
  #    [] -> nil
  #  end
  #end

  #def clear, do: :ets.delete_all_objects(__MODULE__)

  #def read_all,
  #  do: :ets.match_object(__MODULE__, {:"$1", :"_"})
  #      |> Enum.reduce(%{}, fn ({_id, item}, acc) -> Map.put(acc, item.id, item) end)

  def start_link(_args), do: GenServer.start_link(__MODULE__, [], name: __MODULE__)

  def init(_) do
    table = :ets.new(__MODULE__, [:named_table, :public])

    # TODO This should not be here. Fix this later.
    :ets.insert(__MODULE__, {:state, Persistent.read(:state, %State{})})

    {:ok, table}
  end
end
