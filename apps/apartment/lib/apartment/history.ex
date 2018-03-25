defmodule Apartment.History do
  alias Apartment.Persistent

  def save(%Apartment{} = apartment),
    do: Persistent.write({__MODULE__, apartment.id}, apartment)

  def by_id(id), do: Persistent.read({__MODULE__, id})

  def all, do: Persistent.match({{__MODULE__, :"_"}, :"_"})
end
