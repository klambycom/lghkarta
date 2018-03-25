defmodule Apartment.Persistent do
  use GenServer

  #:dets.insert(table, {{:history, 1}, %Apartment{id: 1}})

  def write(key, item), do: :dets.insert(__MODULE__, {key, item})

  #iex(13)> :dets.lookup(table, {:history, 1})
  #[{{:history, 1}, %Apartment{id: 1, url: nil}}]

  def read(key, default \\ nil) do
    case :dets.lookup(__MODULE__, key) do
      [{_key, item}] -> item
      [] -> default
    end
  end

  #iex(16)> :dets.match_object(table, {{:history, :"_"}, :"_"})
  #[{{:history, 1}, %Apartment{id: 1, url: nil}}]

  def match(pattern) do
    case :dets.match_object(__MODULE__, pattern) do
      [] -> nil
      items -> Enum.map(items, fn ({_key, item}) -> item end)
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
    :dets.open_file(__MODULE__, [type: :set])
  end
end
