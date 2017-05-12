defmodule Exmorph.Time do
  @doc """
  Takes a string representing time and returns the integer
  value for that time in nanoseconds.

      ## Examples

      iex> Exmorph.Time.from_string("100000ms")
      1.0e11

      iex> Exmorph.Time.from_string("10s")
      10000000000

      iex> Exmorph.Time.from_string("3min")
      180000000000

      iex> Exmorph.Time.from_string("1hr")
      3600000000000

  """
  def from_string("infinity"), do: :infinity
  def from_string(value) when is_bitstring(value) do
    if Regex.match?(~r/((?:\d*\.)?\d+)(ms|s|m|h)/, value) do
      parse_time(value)
      |> to_nano
    else
      raise "Cannot parse duration #{value}."
    end
  end

  @doc """
  Returns the current system time in nanoseconds.
  """
  def now() do
    :os.system_time(:nano_seconds)
  end

  @doc """
  Takes an atom with a duration as the first element and unit
  of time as the second. Returns the duration converted to
  nanoseconds.

  ## Examples

      iex> Exmorph.Time.to_nano({8_888, :milli_seconds})
      8.888e9

      iex> Exmorph.Time.to_nano({88, :seconds})
      88000000000

      iex> Exmorph.Time.to_nano({64, :minutes})
      3840000000000

      iex> Exmorph.Time.to_nano({4, :hours})
      14400000000000

  """
  def to_nano({time, :milli_seconds}) do
    (time / 1_000) * 1_000_000_000
  end
  def to_nano({time, :seconds}) do
    time * 1_000_000_000
  end
  def to_nano({time, :minutes}) do
    time * 60 * 1_000_000_000
  end
  def to_nano({time, :hours}) do
    time * 3600 * 1_000_000_000
  end
  def to_nano({time, _}), do: time

  defp parse_time(value) when is_bitstring(value) do
    cond do
      String.contains?(value, ".") ->
        {result, unit} = Float.parse(value)
        {result, parse_unit(unit)}
      true ->
        {result, unit} = Integer.parse(value)
        {result, parse_unit(unit)}
    end
  end

  defp parse_unit(unit) do
    case unit do
      "ms" -> :milli_seconds
      "msec" -> :milli_seconds
      "s" -> :seconds
      "sec" -> :seconds
      "m" -> :minutes
      "min" -> :minutes
      "h" -> :hours
      "hr" -> :hours
      _ -> :unknown
    end
  end
end
