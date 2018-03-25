defmodule Crawler.Geocoding do
  defstruct street_name: nil,
            street_number: nil,
            area: nil,
            city: nil,
            county: nil,
            country: nil,
            postal_code: nil,
            location: nil,
            formatted: nil

  @google_api_key Application.get_env(:crawler, :google_api_key)
  @geocoding_url "https://maps.googleapis.com/maps/api/geocode/json?"

  def get(address) do
    %HTTPoison.Response{body: html} =
      build_url(address)
      |> HTTPoison.get!

    %{"results" => [result | _]} = Poison.decode!(html)

    result["address_components"] |> Enum.reduce(%__MODULE__{}, &component/2)
    |> Map.put(:location, %{lat: result["geometry"]["location"]["lat"], lng: result["geometry"]["location"]["lng"]})
    |> Map.put(:formatted, result["formatted_address"])
  end

  defp build_url(address) do
    params = %{
      address: address,
      key: @google_api_key,
      language: "sv"
    }

    @geocoding_url <> URI.encode_query(params)
  end

  defp component(%{"long_name" => long_name, "types" => ["street_number"]}, result),
    do: %{result | street_number: long_name}

  defp component(%{"long_name" => long_name, "types" => ["route"]}, result),
    do: %{result | street_name: long_name}

  defp component(%{"long_name" => long_name, "types" => ["political", "sublocality", "sublocality_level_1"]}, result),
    do: %{result | area: long_name}

  defp component(%{"long_name" => long_name, "types" => ["postal_town"]}, result),
    do: %{result | city: long_name}

  defp component(%{"long_name" => long_name, "types" => ["locality", "political"]}, result),
    do: %{result | city: long_name}

  defp component(%{"long_name" => long_name, "types" => ["administrative_area_level_1", "political"]}, result),
    do: %{result | county: long_name}

  defp component(%{"long_name" => long_name, "types" => ["country", "political"]}, result),
    do: %{result | country: long_name}

  defp component(%{"long_name" => long_name, "types" => ["postal_code"]}, result),
    do: %{result | postal_code: long_name}

  defp component(_component, result), do: result
end
