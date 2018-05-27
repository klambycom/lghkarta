defmodule FilterTest do
  use ExUnit.Case
  doctest Filter

  test "find all apartments cheaper than the max rent" do
    assert Filter.from_map(all_apartments(), %{"max_rent" => 9500}) == [
      %Apartment{
        facts: %Apartment.Facts{area: 86, rent: 9149, rooms: 4},
        type: :apartment,
        url: "https://www.boplatssyd.se/lagenhet/403854"
      },
      %Apartment{
        facts: %Apartment.Facts{area: 62, rent: 7951, rooms: 2},
        type: :apartment,
        url: "https://www.boplatssyd.se/lagenhet/404414"
      }
    ]
  end

  test "find all apartments with the correct number of rooms" do
    assert Filter.from_map(all_apartments(), %{"rooms" => {[2, 3], 8}}) == [
      %Apartment{
        facts: %Apartment.Facts{area: 62, rent: 7951, rooms: 2},
        type: :apartment,
        url: "https://www.boplatssyd.se/lagenhet/404414"
      },
      %Apartment{
        facts: %Apartment.Facts{area: 80, rent: 9778, rooms: 3},
        type: :other,
        url: "https://www.boplatssyd.se/lagenhet/404441"
      }
    ]
  end

  test "find all apartments with more than, or equal to, n rooms" do
    assert Filter.from_map(all_apartments(), %{"rooms" => {[7, 8], 8}}) == [
      %Apartment{
        facts: %Apartment.Facts{area: 534, rent: 50049, rooms: 10},
        type: :apartment,
        url: "https://www.boplatssyd.se/lagenhet/404069"
      }
    ]
  end

  test "find all apartments of selected types" do
    assert Filter.from_map(all_apartments(), %{"type" => ["senior", "other"]}) == [
      %Apartment{
        facts: %Apartment.Facts{area: 104, rent: 11563, rooms: 4},
        type: :senior,
        url: "https://www.boplatssyd.se/lagenhet/404432"
      },
      %Apartment{
        facts: %Apartment.Facts{area: 80, rent: 9778, rooms: 3},
        type: :other,
        url: "https://www.boplatssyd.se/lagenhet/404441"
      }
    ]
  end

  def all_apartments(),
    do: [
      %Apartment{
        facts: %Apartment.Facts{area: 86, rent: 9149, rooms: 4},
        type: :apartment,
        url: "https://www.boplatssyd.se/lagenhet/403854"
      },
      %Apartment{
        facts: %Apartment.Facts{area: 104, rent: 11563, rooms: 4},
        type: :senior,
        url: "https://www.boplatssyd.se/lagenhet/404432"
      },
      %Apartment{
        facts: %Apartment.Facts{area: 62, rent: 7951, rooms: 2},
        type: :apartment,
        url: "https://www.boplatssyd.se/lagenhet/404414"
      },
      %Apartment{
        facts: %Apartment.Facts{area: 80, rent: 9778, rooms: 3},
        type: :other,
        url: "https://www.boplatssyd.se/lagenhet/404441"
      },
      %Apartment{
        facts: %Apartment.Facts{area: 534, rent: 50049, rooms: 10},
        type: :apartment,
        url: "https://www.boplatssyd.se/lagenhet/404069"
      }
    ]
end
