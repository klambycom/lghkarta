defmodule Web.Resolver do
  def apartment(_root, %{id: id}, _info), do: {:ok, Apartment.by_id(id)}

  def filter(_root, args, _info) do
    filter =
      args
      |> Map.take([:max_rent, :types])
      |> Map.put(:rooms, {Map.get(args, :rooms, []), Map.get(args, :max_rooms, 8)})

    apartments =
      Apartment.all
      |> Filter.from_map(filter)

    {:ok, %{nr_of_items: length(apartments), items: apartments}}
  end

  def all_apartments(_root, _args, _info), do: {:ok, Apartment.all}

  def facts(%Apartment{facts: facts}, _args, _info), do: {:ok, facts}

  def address(%Apartment{address: address}, _args, _info), do: {:ok, address}

  def location(%Apartment{address: address}, _args, _info), do: {:ok, address.location}
end
