defmodule Web.PageController do
  use Web, :controller

  def index(conn, _params) do
    render conn, "index.html", apartments: Apartment.all, test: List.first(Apartment.all)
  end

  def fetch(conn, _params) do
    ids = Apartment.all |> Enum.map(fn item -> item.id end)

    items =
      Crawler.sitemap("https://www.boplatssyd.se/lagenheter")
      |> Enum.filter(fn item -> not Enum.member?(ids, item.id) end)
      #|> Enum.take(20)
      |> Enum.map(&crawl_item/1)
      |> Enum.map(&create_apartment/1)

    for item <- items, do: Apartment.save(item)

    render conn, "fetch.html", items: items
  end

  defp crawl_item(item), do: item |> Crawler.fetch_location |> Crawler.fetch_page

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
