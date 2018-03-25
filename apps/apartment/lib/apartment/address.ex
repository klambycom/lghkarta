defmodule Apartment.Address do
  defstruct area1: nil,
            area2: nil,
            city: nil,
            country: nil,
            county: nil,
            formatted: nil,
            location: %{lat: 0.0, lng: 0.0},
            postal_code: nil,
            street_name: nil,
            street_number: nil
end
