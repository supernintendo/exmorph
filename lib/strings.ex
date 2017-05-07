defmodule Exmorph.Strings do
  alias Exmorph.Cast
  alias Exmorph.Easing

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
