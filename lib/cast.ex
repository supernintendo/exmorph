defmodule Exmorph.Cast do
  @doc """
  Converts a bitstring to a float or integer.
  Returns the value in its original form if
  it cannot be cast.

  ## Examples

      iex> Exmorph.Cast.to_numeric(".10")
      0.1

      iex> Exmorph.Cast.to_numeric("10")
      10

  """
  def to_numeric(value) when is_bitstring(value) do
    cond do
      matches_float?(value) -> to_float(value)
      matches_integer?(value) -> to_integer(value)
      true -> value
    end
  end

  @doc """
  Converts a bitstring to a float.

  ## Examples

      iex> Exmorph.Cast.to_float(".1")
      0.1

      iex> Exmorph.Cast.to_float("3.14159265359")
      3.14159265359

  """
  def to_float(value) when is_bitstring(value) do
    {value, _rem} = Float.parse("0#{value}")

    value
  end

  @doc """
  Converts a bitstring to an integer.

  ## Examples

      iex> Exmorph.Cast.to_integer("32")
      32

  """
  def to_integer(value) when is_bitstring(value) do
    {value, _rem} = Integer.parse(value)

    value
  end

  @doc """
  Returns true or false, depending on if the
  passed string can be cast to a float.

  ## Examples

      iex> Exmorph.Cast.matches_float?(".1")
      true

      iex> Exmorph.Cast.matches_float?("3.14159265359")
      true

      iex> Exmorph.Cast.matches_float?("12")
      false

  """
  def matches_float?(value) when is_bitstring(value) do
    Regex.match?(~r/\d*\.\d*/, value)
  end

  @doc """
  Returns true or false, depending on if the
  passed string can be cast to an integer.

  ## Examples

      iex> Exmorph.Cast.matches_integer?("32")
      true

      iex> Exmorph.Cast.matches_integer?("3.14159265359")
      false

  """
  def matches_integer?(value) when is_bitstring(value) do
    Regex.match?(~r/^[0-9]*$/, value)
  end
end
