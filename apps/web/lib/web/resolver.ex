defmodule Web.Resolver do
  def apartment(_root, %{id: id}, _info), do: {:ok, Apartment.by_id(id)}

  def all_apartments(_root, _args, _info), do: {:ok, Apartment.all}

  def facts(%Apartment{facts: facts}, _args, _info), do: {:ok, facts}

  def address(%Apartment{address: address}, _args, _info), do: {:ok, address}

  def location(%Apartment{address: address}, _args, _info), do: {:ok, address.location}
end