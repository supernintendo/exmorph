# Exmorph

Exmorph is a simple tweening and data transformation library for Elixir.

## Usage

Add to your mix.exs:

`{:exmorph, "~> 0.1.0"}`

Use `import Exmorph` to enable the `~t` sigil which can be used to generate
a `%Exmorph.Tween{}`. The contents of the sigil are used to determine the
properties of the tween:

```elixir
iex> ~t(from 0 to 100 over 8sec ease quad_in)
%Exmorph.Tween{delta: 100, duration: 8000000000, easing: :quad_in,
 ends_at: 1494150596602924000, from: 0, started_at: 1494150588602924000,
 to: 100}
```

`~t` is just an alias for the `tween` function provided by `Exmorph`. This
function also takes an enumerable as a second argument. When binding names
within curly braces (`{}`) are present in the provided string, they are
replaced with values from the enumerable.

```elixir
iex> tween("from {here} to {there} over {time}s", %{"here" => 32, "there" => 64, "time" => 3})
%Exmorph.Tween{delta: 32, duration: 3000000000, easing: :linear,
 ends_at: 1494153281094819000, from: 32, started_at: 1494153278094819000,
 to: 64}
```

By importing `Exmorph`, you also pull in the `tween_value` function. This
function takes an `%Exmorph.Tween{}` and returns the transformed value
based on the current time. An interval of time can also be passed as the
second argument to get a specific value in time after (or even before)
the time it was generated.

```elixir
iex> tween = ~t(from 50 to 200 over 25sec)

# Wait a short while...
iex> tween_value(tween)
74.07077

# Wait 25 seconds...
iex> tween_value(tween)
200

# Look back in time...
iex> tween_value(tween, {-25, :seconds})
-100.0
```

## License

Exmorph is free software released under the [Apache License 2.0](LICENSE.md).
