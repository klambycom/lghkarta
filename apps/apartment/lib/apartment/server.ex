defmodule Apartment.Server do
  use GenServer
  alias Apartment.{State, Cache, Persistent}

  def start_link(_state) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_), do: {:ok, Cache.read(:state, %State{})}

  def handle_cast({:add, item}, state) do
    new_state = State.add(state, item)

    Cache.write(:state, new_state)
    Persistent.write(:state, new_state)

    {:noreply, new_state}
  end

  def handle_call({:by_id, id}, _from, state), do: {:reply, Map.get(state.items, id), state}

  def handle_call(:all, _from, state) do
    new_state = State.remove_expired(state)
    {:reply, Map.values(new_state.items), new_state}
  end
end
