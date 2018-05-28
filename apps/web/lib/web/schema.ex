defmodule Web.Schema do
  use Absinthe.Schema
  alias Web.Resolver

  import_types Absinthe.Type.Custom

  object :result do
    field :nr_of_items, non_null(:integer)
    field :items, non_null(list_of(:apartment))
  end

  object :apartment do
    field :id, non_null(:id)
    field :url, non_null(:string)
    field :type, non_null(:string)
    field :available_date, non_null(:datetime)
    field :last_date, non_null(:datetime)
    field :facts, non_null(:facts) do
      resolve &Resolver.facts/3
    end
    field :address, non_null(:address) do
      resolve &Resolver.address/3
    end
    field :location, non_null(:geo_point) do
      resolve &Resolver.location/3
    end
  end

  object :facts do
     field :area, non_null(:integer)
     field :rent, non_null(:integer)
     field :rooms, non_null(:integer)
     field :balcony, :string
     field :balcony_direction, :string
     field :bathtub, :string
     field :elevator, :string
     field :floor, :string
     field :internet, :string
     field :landlord, :string
     field :tv, :string
     field :yard, :string
  end

  object :address do
    field :area1, :string
    field :area2, :string
    field :city, :string
    field :country, :string
    field :county, :string
    field :formatted, :string
    field :postal_code, :string
    field :street_name, :string
    field :street_number, :string
  end

  object :geo_point do
    field :lat, non_null(:float)
    field :lng, non_null(:float)
  end

  query do
    field :apartment, non_null(:apartment) do
      arg :id, non_null(:id)
      resolve &Resolver.apartment/3
    end

    field :filter, non_null(:result) do
      arg :max_rent, :integer
      arg :rooms, list_of(:integer)
      arg :max_rooms, :integer
      arg :types, list_of(:string)

      resolve &Resolver.filter/3
    end
  end
end
