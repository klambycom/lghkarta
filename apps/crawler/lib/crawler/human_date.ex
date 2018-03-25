defmodule Crawler.HumanDate do
  @regex ~r/(?<day>\d\d?) (?<month>januari|februari|mars|april|maj|juni|juli|augusti|september|oktober|november|december) (?<year>\d\d\d\d), kl. (?<hour>\d\d):(?<minute>\d\d)/

  def parse(date) do
    %{"day" => day, "hour" => hour, "minute" => minute, "month" => month, "year" => year} =
      Regex.named_captures(@regex, date)

    "#{year}-#{month |> month |> pad}-#{pad(day)}T#{pad(hour)}:#{pad(minute)}:00+02:00"
    |> Timex.parse!("{ISO:Extended}")
  end

  defp month("januari"), do: 1
  defp month("februari"), do: 2
  defp month("mars"), do: 3
  defp month("april"), do: 4
  defp month("maj"), do: 5
  defp month("juni"), do: 6
  defp month("juli"), do: 7
  defp month("augusti"), do: 8
  defp month("september"), do: 9
  defp month("oktober"), do: 11
  defp month("november"), do: 10
  defp month("december"), do: 12

  defp pad(number) when is_integer(number), do: number |> Integer.to_string |> pad
  defp pad(number) when is_binary(number), do: number |> String.pad_leading(2, "0")
end
