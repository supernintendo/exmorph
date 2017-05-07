defmodule Exmorph.Strings do
  alias Exmorph.Cast
  alias Exmorph.Easing

  @doc """
  Takes two arguments, a tween string (for instance, the string
  passed to Exmorph's ~t sigil) and an enumerable. Returns a
  string with all bindings (designated by wrapping the binding
  names in curly braces) replaced with the corresponding
  values within the enumerable.

  If any of the binding names within the string are missing
  a corresponding key value / pair within the enumerable,
  an exception is thrown.

  ## Examples

      iex> params = %{"start" => 25, "end" => 50, "duration" => 10}
      iex> Exmorph.Strings.interpolate_bindings("from {start} to {end} over {duration}s", params)
      "from 25 to 50 over 10s"

  """
  def interpolate_bindings(string, bindings) do
    Regex.scan(~r/{(.*?)}/, string)
    |> Enum.reduce(string, fn [_capture, key], result ->
      if bindings[key] do
        String.replace(result, "{#{key}}", "#{bindings[key]}")
      else
        throw "Key #{key} not found in bindings #{inspect bindings}."
      end
    end)
  end

  @doc """
  Parses a tween string. The string is broken up into two-word
  chunks which are converted to key value pairs within a map.
  This map is eventually merged with %Exmorph.Tween{}.

  ## Examples

      iex> Exmorph.Strings.parse("from 25 to 75 over 1s")
      %{duration: 1000000000, from: 25, to: 75}

      iex> Exmorph.Strings.parse("from 25 to 75 over 1.5s ease cubic_out")
      %{duration: 1.5e9, easing: :cubic_out, from: 25, to: 75}

  """
  def parse(string) when is_bitstring(string) do
    string
    |> String.split(" ")
    |> decode
  end

  defp decode(parts) when is_list(parts) do
    parts
    |> Enum.chunk(2)
    |> Enum.reduce(%{}, fn chunk, result ->
      case chunk do
        ["ease", value] ->
          if Easing.valid?(value) do
            Map.put(result, :easing, String.to_existing_atom(value))
          else
            Map.put(result, :easing, :linear)
          end
        ["from", value] ->
          Map.put(result, :from, Cast.to_numeric(value))
        ["over", value] ->
          Map.put(result, :duration, Exmorph.Time.from_string(value))
        ["to", value] ->
          Map.put(result, :to, Cast.to_numeric(value))
        _ -> result
      end
    end)
  end
end
