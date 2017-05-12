defmodule Exmorph.CastTest do
  alias Exmorph.Cast
  use ExUnit.Case
  doctest Exmorph.Cast

  test "&to_numeric/1" do
    assert Cast.to_numeric("1") == 1
    assert Cast.to_numeric("1.0") == 1.0
    assert Cast.to_numeric("foo") == "foo"
  end

  test "&to_integer/1" do
    assert Cast.to_numeric("0") == 0
    assert Cast.to_numeric("10") == 10
    assert Cast.to_numeric("64") == 64
  end

  test "&to_float/1" do
    assert Cast.to_float("0.64") == 0.64
    assert Cast.to_float(".64") == 0.64
    assert Cast.to_float("64.0") == 64.0
    assert Cast.to_float("64.64") == 64.64
  end

  test "&matches_float?/1" do
    assert Cast.matches_float?("1.0")
    assert Cast.matches_float?(".1")
    assert Cast.matches_float?("3.14159265359")
    refute Cast.matches_float?("64")
    refute Cast.matches_float?("foo")
  end

  test "&matches_integer?/1" do
    assert Cast.matches_integer?("1")
    assert Cast.matches_integer?("64")
    assert Cast.matches_integer?("100")
    refute Cast.matches_integer?("2.71828")
    refute Cast.matches_integer?("foo")
  end
end
