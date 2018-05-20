defmodule Web.PageController do
  use Web, :controller

  def index(conn, _params) do
    render(
      conn,
      "index.html",
      apartments: Apartment.all |> Enum.filter(fn x -> not is_nil(x.address.location) end)
    )
  end

  def fetch(conn, _params) do
    ids = Apartment.all |> Enum.map(fn item -> item.id end)

    items =
      Crawler.sitemap("https://www.boplatssyd.se/lagenheter?location[cities][]=11")
      |> Enum.filter(fn item -> not Enum.member?(ids, item.id) end)
      |> Enum.take(50)
      |> Enum.map(&crawl_item/1)
      |> Enum.map(&create_apartment/1)

    for item <- items, do: Apartment.save(item)

    output =
      items
      |> Enum.map(&Poison.encode!/1)
      |> Enum.join("\n")

    text conn, output
  end
  defp crawl_item(item) do
    # Google Maps Geolocation API only allows 50 requests per second. Add
    # a short sleep to not send too many requests.
    Process.sleep(50)

    item |> Crawler.fetch_location |> Crawler.fetch_page
  end

  defp create_apartment(item) do
    %Apartment{
      id: item.id,
      url: item.url,
      available_date: item.available,
      last_date: item.last_date,
      type: item.type,
      address: %Apartment.Address{
        area1: item.address.area,
        area2: item.geo.area,
        city: item.geo.city,
        country: item.geo.country,
        county: item.geo.county,
        formatted: item.geo.formatted,
        location: item.geo.location, #%{lat: Map.get(item.geo.location, :lat, 0.0), lng: Map.get(item.geo.location, :lng, 0.0)},
        postal_code: item.geo.postal_code,
        street_name: item.geo.street_name,
        street_number: item.geo.street_number
      },
      facts: %Apartment.Facts{
        area: item.area,
        rent: item.rent,
        balcony: item.balcony,
        balcony_direction: item.balcony_direction,
        bathtub: item.bathtub,
        elevator: item.elevator,
        floor: item.floor,
        internet: item.internet,
        landlord: item.landlord,
        rooms: item.rooms,
        tv: item.tv,
        yard: item.yard
      }
    }
  end
end
