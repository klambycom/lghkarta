defmodule Crawler.Item do
  alias Crawler.Geocoding

  defstruct id: nil,
            url: nil,
            rooms: nil,
            rent: nil,
            area: nil,
            landlord: nil,
            available: nil,
            address: nil,
            geo: %Geocoding{},
            last_date: nil,
            type: nil,
            bathtub: nil,
            balcony: nil,
            balcony_direction: nil,
            tv: nil,
            internet: nil,
            floor: nil,
            elevator: nil,
            yard: nil

  def new(url) do
    %__MODULE__{
      id: :crypto.hash(:md5, url) |> Base.encode16(case: :lower),
      url: url
    }
  end
end
