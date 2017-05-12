defmodule Exmorph.Easing do
  @easings ~w(
    linear
    quad_in
    quad_out
    cubic_in
    cubic_out
    quart_in
    quart_out
    quint_in
    quint_out
    sine_in
    sine_out
  )

  @doc """
  Takes and returns the time variable to be used within
  a tweening function. The returned value will be modified
  based on the second argument, an atom representing the
  easing function.

  ## Examples

      iex> Exmorph.Easing.ease(2, :linear)
      2

      iex> Exmorph.Easing.ease(2, :quad_in)
      4

      iex> Exmorph.Easing.ease(2, :quad_out)
      0

      iex> Exmorph.Easing.ease(2, :cubic_in)
      8

      iex> Exmorph.Easing.ease(2, :cubic_out)
      2

      iex> Exmorph.Easing.ease(2, :quart_in)
      16

      iex> Exmorph.Easing.ease(2, :quart_out)
      0

      iex> Exmorph.Easing.ease(2, :quint_in)
      32

      iex> Exmorph.Easing.ease(2, :quint_out)
      2

      iex> Exmorph.Easing.ease(2, :sine_in)
      2.0

      iex> Exmorph.Easing.ease(2, :sine_out)
      1.2246467991473532e-16

  """
  def ease(t, :linear), do: t
  def ease(t, :quad_in), do: t * t
  def ease(t, :quad_out), do: -1 * t * (t - 2)
  def ease(t, :cubic_in), do: t * t * t
  def ease(t, :cubic_out) do
    t = t - 1
    t * t * t + 1
  end
  def ease(t, :quart_in), do: t * t * t * t
  def ease(t, :quart_out) do
    t = t - 1
    -1 * (t * t * t * t - 1)
  end
  def ease(t, :quint_in), do: t * t * t * t * t
  def ease(t, :quint_out) do
    t = t - 1
    (t * t * t * t * t + 1)
  end
  def ease(t, :sine_in) do
    -1 * :math.cos(t * (:math.pi() / 2)) + 1
  end
  def ease(t, :sine_out) do
    :math.sin(t * (:math.pi() / 2))
  end

  @doc """
  Takes and string and returns whether that string exists
  within the @easings module attribute.

  ## Examples

      iex> Exmorph.Easing.valid?("linear")
      true

      iex> Exmorph.Easing.valid?("foo")
      false

  """
  def valid?(easing) do
    Enum.member?(@easings, easing)
  end
end
