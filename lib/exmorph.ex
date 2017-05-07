defmodule Exmorph do
  alias Exmorph.Easing
  alias Exmorph.Tween

  @doc """
  Alias for Exmorph.tween/1.
  """
  def sigil_t(string, _opts), do: tween(string)

  @doc """
  Returns an %Exmorph.Tween{}, decoding the attributes for the
  tween from the provided string (see Exmorph.Strings.parse/1).
  """
  def tween(string) when is_bitstring(string) do
    %Exmorph.Tween{}
    |> struct(Exmorph.Strings.parse(string))
    |> set_time_fields
  end

  @doc """
  Returns the current value for an %Exmorph.Tween{}, using the
  current time to determine how much time has elasped since the
  tween's started_at time. Optionally, a time tuple (as in,
  one that would be parsed with Exmorph.Time) can be passed
  as the second argument. This will return the value as it
  would exist after that amount of time had elapsed.

  If the time elapsed exceeds the duration of the tween, the
  tween's `to` (final) value is returned.

  ## Examples

      iex> Exmorph.tween("from 0 to 100 over 10s") |> Exmorph.tween_value() |> round
      0

      iex> Exmorph.tween("from 0 to 100 over 10s") |> Exmorph.tween_value({4, :seconds}) |> round
      40

      iex> Exmorph.tween("from 0 to 100 over 10s") |> Exmorph.tween_value({20, :seconds}) |> round
      100

  """
  def tween_value(%Tween{} = tween), do: tween_value(tween, Exmorph.Time.now())
  def tween_value(%Tween{} = tween, :now), do: tween_value(tween, Exmorph.Time.now())
  def tween_value(%Tween{} = tween, {time, unit}) do
    tween_value(tween, tween.started_at + Exmorph.Time.to_nano({time, unit}))
  end
  def tween_value(%Tween{} = tween, time) do
    cond do
      time > tween.ends_at ->
        tween.to
      true ->
        tween.delta * Easing.ease((time - tween.started_at) / tween.duration, tween.easing) + tween.from
    end
  end

  defp set_time_fields(%Tween{duration: duration, from: from, to: to} = tween) do
    started_at = Exmorph.Time.now()
    ends_at = Exmorph.Time.now() + duration

    struct(tween, %{
      delta: to - from,
      ends_at: ends_at,
      started_at: started_at
    })
  end
end
