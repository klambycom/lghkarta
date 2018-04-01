defmodule Crawler do
  @moduledoc """
  Documentation for Crawler.
  """
  alias Crawler.{Item, HumanDate}

  def sitemap(url) do
    %HTTPoison.Response{body: html} = HTTPoison.get!(url)

    html
    |> Floki.find(".object-teaser")
    |> Enum.map(&create_object/1)
  end

  def fetch_location(%Item{address: %{street: street, city: city}} = item) do
    %{item | geo: Crawler.Geocoding.get("#{street}, #{city}, Sverige")}
  end

  def fetch_page(%Item{url: url} = item) do
    %HTTPoison.Response{body: html} = HTTPoison.get!(url)

    item
    |> Map.put(:last_date, html |> Floki.find(".user-queue.last .number") |> Floki.text |> HumanDate.parse)
    |> Map.put(:type, html |> Floki.find(".fact.type .fact-content") |> Floki.text |> String.trim |> type)
    |> Map.put(:bathtub, html |> Floki.find(".fact.bathroom-desc .fact-content") |> Floki.text |> String.trim)
    |> Map.put(:balcony, html |> Floki.find(".fact.balcony-desc .fact-content") |> Floki.text |> String.trim)
    |> Map.put(:balcony_direction, html |> Floki.find(".fact.balcony-direc .fact-content") |> Floki.text |> String.trim)
    |> Map.put(:tv, html |> Floki.find(".fact.tv .fact-content") |> Floki.text |> String.trim)
    |> Map.put(:internet, html |> Floki.find(".fact.broadband .fact-content") |> Floki.text |> String.trim)
    |> Map.put(:floor, html |> Floki.find(".fact.floor .fact-content") |> Floki.text |> String.trim)
    |> Map.put(:elevator, html |> Floki.find(".fact.elevator .fact-content") |> Floki.text |> String.trim)
    |> Map.put(:yard, html |> Floki.find(".fact.yard .fact-content") |> Floki.text |> String.trim)
  end

  defp create_object(item) do
    path =
      item
      |> Floki.find(".apartment")
      |> Floki.attribute("href")
      |> List.first

    Item.new("https://www.boplatssyd.se#{path}")
    |> Map.put(:rooms, find_attr(item, ".size-designation.rooms", "data-apartment-rooms") |> String.to_integer)
    |> Map.put(:area, find_attr(item, ".square-area.size-kvm.size", "data-apartment-size") |> String.to_integer)
    |> Map.put(:rent, find_attr(item, ".total-rent.rent", "data-apartment-rent") |> String.to_integer)
    |> Map.put(:landlord, find_attr(item, ".host-name.landlord", "data-apartment-landlord"))
    |> Map.put(:available, find_attr(item, ".available-date.available", "data-apartment-available") |> Timex.parse!("{ISO:Extended}"))
    |> Map.put(:address, %{
      street: Floki.find(item, ".address") |> Floki.text,
      area: Floki.find(item, ".area") |> Floki.text,
      city: Floki.find(item, ".municipality") |> Floki.text
    })
  end

  defp find_attr(html, selector, attribute),
    do: html
        |> Floki.find(selector)
        |> Floki.attribute(attribute)
        |> List.first

  defp type("Lägenhet"), do: :apartment
  defp type("Korttidskontrakt"), do: :short_term
  defp type("Seniorboende"), do: :senior
  defp type("Nybyggnationslägenhet"), do: :new_construction
  defp type("Trygghetsboende"), do: :older_tenant
  defp type("Ungdomslägenhet"), do: :youth_apartment
  defp type("Studentbostad"), do: :student_housing
end
