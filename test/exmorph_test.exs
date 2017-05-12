defmodule ExmorphTest do
  alias Exmorph.Time
  import Exmorph
  use ExUnit.Case
  doctest Exmorph

  defp collect_samples(tween) do
    {
      tween_value(tween, :now),
      tween_value(tween, {tween.duration * 0.25, :nano_seconds}),
      tween_value(tween, {tween.duration * 0.50, :nano_seconds}),
      tween_value(tween, {tween.duration * 0.75, :nano_seconds}),
      tween_value(tween, {tween.duration, :nano_seconds}),
      tween_value(tween, {tween.duration + 1_000_000, :nano_seconds})
    }
  end

  defp good_time(a, b, range), do: abs((b - a)) < range

  test "constructing a finite tween" do
    current_time = :os.system_time(:nano_seconds)
    tween = ~t(from 0 to 100 over 10s ease linear)

    assert tween.duration == 10_000_000_000
    assert tween.easing == :linear
    assert tween.from == 0
    assert tween.to == 100
    assert good_time(current_time, tween.started_at, Time.to_nano({1, :seconds}))
    assert good_time(tween.ends_at, tween.started_at + tween.duration, Time.to_nano({1, :seconds}))
  end

  test "constructing an infinite tween" do
    current_time = :os.system_time(:nano_seconds)
    tween = ~t(from 0 add 10 every 1s over infinity)

    assert tween.add == 10
    assert tween.duration == :infinity
    assert tween.from == 0
    assert is_nil(tween.to)
    assert good_time(current_time, tween.started_at, Time.to_nano({1, :seconds}))
    assert is_nil(tween.ends_at)
  end

  test "getting a value from a linear tween" do
    tween = ~t(from 0 to 100 over 100s ease linear)

    {a, b, c, d, e, f} = collect_samples(tween)

    assert good_time(a, 0, 1)
    assert good_time(b, 25, 1)
    assert good_time(c, 50, 1)
    assert good_time(d, 75, 1)
    assert good_time(e, 100, 1)
    assert f == 100
  end

  test "getting a value from a quad_in tween" do
    tween = ~t(from 0 to 100 over 100s ease quad_in)
    {a, b, c, d, e, f} = collect_samples(tween)

    assert good_time(a, 0, 1)
    assert good_time(b, 6, 1)
    assert good_time(c, 25, 1)
    assert good_time(d, 56, 1)
    assert good_time(e, 100, 1)
    assert f == 100
  end

  test "getting a value from a quad_out tween" do
    tween = ~t(from 0 to 100 over 100s ease quad_out)
    {a, b, c, d, e, f} = collect_samples(tween)

    assert good_time(a, 0, 1)
    assert good_time(b, 43, 1)
    assert good_time(c, 75, 1)
    assert good_time(d, 93, 1)
    assert good_time(e, 100, 1)
    assert f == 100
  end

  test "getting a value from a cubic_in tween" do
    tween = ~t(from 0 to 100 over 100s ease cubic_in)
    {a, b, c, d, e, f} = collect_samples(tween)

    assert good_time(a, 0, 1)
    assert good_time(b, 1, 1)
    assert good_time(c, 12, 1)
    assert good_time(d, 42, 1)
    assert good_time(e, 100, 1)
    assert f == 100
  end

  test "getting a value from a cubic_out tween" do
    tween = ~t(from 0 to 100 over 100s ease cubic_out)
    {a, b, c, d, e, f} = collect_samples(tween)

    assert good_time(a, 0, 1)
    assert good_time(b, 57, 1)
    assert good_time(c, 87, 1)
    assert good_time(d, 98, 1)
    assert good_time(e, 100, 1)
    assert f == 100
  end

  test "getting a value from a quart_in tween" do
    tween = ~t(from 0 to 100 over 100s ease quart_in)
    {a, b, c, d, e, f} = collect_samples(tween)

    assert good_time(a, 0, 1)
    assert good_time(b, 1, 1)
    assert good_time(c, 6, 1)
    assert good_time(d, 31, 1)
    assert good_time(e, 100, 1)
    assert f == 100
  end

  test "getting a value from a quart_out tween" do
    tween = ~t(from 0 to 100 over 100s ease quart_out)
    {a, b, c, d, e, f} = collect_samples(tween)

    assert good_time(a, 0, 1)
    assert good_time(b, 68, 1)
    assert good_time(c, 93, 1)
    assert good_time(d, 99, 1)
    assert good_time(e, 100, 1)
    assert f == 100
  end

  test "getting a value from a quint_in tween" do
    tween = ~t(from 0 to 100 over 100s ease quint_in)
    {a, b, c, d, e, f} = collect_samples(tween)

    assert good_time(a, 0, 1)
    assert good_time(b, 1, 1)
    assert good_time(c, 3, 1)
    assert good_time(d, 23, 1)
    assert good_time(e, 100, 1)
    assert f == 100
  end

  test "getting a value from a quint_out tween" do
    tween = ~t(from 0 to 100 over 100s ease quint_out)
    {a, b, c, d, e, f} = collect_samples(tween)

    assert good_time(a, 0, 1)
    assert good_time(b, 76, 1)
    assert good_time(c, 96, 1)
    assert good_time(d, 99, 1)
    assert good_time(e, 100, 1)
    assert f == 100
  end

  test "getting a value from a sine_in tween" do
    tween = ~t(from 0 to 100 over 100s ease sine_in)
    {a, b, c, d, e, f} = collect_samples(tween)

    assert good_time(a, 0, 1)
    assert good_time(b, 7, 1)
    assert good_time(c, 29, 1)
    assert good_time(d, 61, 1)
    assert good_time(e, 100, 1)
    assert f == 100
  end

  test "getting a value from a sine_out tween" do
    tween = ~t(from 0 to 100 over 100s ease sine_out)
    {a, b, c, d, e, f} = collect_samples(tween)

    assert good_time(a, 0, 1)
    assert good_time(b, 38, 1)
    assert good_time(c, 70, 1)
    assert good_time(d, 92, 1)
    assert good_time(e, 100, 1)
    assert f == 100
  end
end
