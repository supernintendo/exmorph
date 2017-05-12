defmodule Exmorph.StringsTest do
  use ExUnit.Case
  doctest Exmorph.Strings

  test "&parse/1" do
    tests =
      %{
        "" => %{},
        "malformatted string" => %{},
        "from 25" => %{from: 25},
        "to 75" => %{to: 75},
        "ease linear" => %{easing: :linear},
        "ease fallback" => %{easing: :linear},
        "over 100ms" => %{duration: 1.0e8},
        "from 25 to 75 over 100ms ease quad_in" => %{duration: 1.0e8, easing: :quad_in, from: 25, to: 75}
      }

    for {string, expected_result} <- tests do
      assert Exmorph.Strings.parse(string) == expected_result
    end
  end
end
