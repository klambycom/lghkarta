defmodule Web.PageView do
  use Web, :view

  def format(%DateTime{} = date),
    do: date
        |> Timex.format!("%Y-%m-%dT%H:%M:%S", :strftime)
end
