defmodule Exmorph.TimeTest do
  use ExUnit.Case
  doctest Exmorph.Time

  test "&from_string/1" do
    assert Exmorph.Time.from_string("1000ms") == 1_000_000_000
    assert Exmorph.Time.from_string("1000msec") == 1_000_000_000
    assert Exmorph.Time.from_string("1s") == 1_000_000_000
    assert Exmorph.Time.from_string("1sec") == 1_000_000_000
    assert Exmorph.Time.from_string("1m") == 60_000_000_000
    assert Exmorph.Time.from_string("1min") == 60_000_000_000
    assert Exmorph.Time.from_string("1h") == 3_600_000_000_000
    assert Exmorph.Time.from_string("1hr") == 3_600_000_000_000
    assert_raise RuntimeError, fn -> Exmorph.Time.from_string("foo") end
  end

  test "&to_nano/1" do
    assert Exmorph.Time.to_nano({1_000, :milli_seconds}) == 1_000_000_000
    assert Exmorph.Time.to_nano({1, :seconds}) == 1_000_000_000
    assert Exmorph.Time.to_nano({1, :minutes}) == 60_000_000_000
    assert Exmorph.Time.to_nano({1, :hours}) == 3_600_000_000_000
  end
end
