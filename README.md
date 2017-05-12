# Exmorph

Exmorph is a simple tweening and data transformation library for Elixir.

[![Build Status](https://travis-ci.org/supernintendo/exmorph.svg)](https://travis-ci.org/supernintendo/exmorph)
[![Coverage Status](https://coveralls.io/repos/github/supernintendo/exmorph/badge.svg?branch=master)](https://coveralls.io/github/supernintendo/exmorph?branch=master)
[![Hex.pm](https://img.shields.io/hexpm/v/exmorph.svg?style=flat)](https://hex.pm/packages/exmorph/1.0.2)
[![Hex.pm](https://img.shields.io/hexpm/dt/exmorph.svg?style=flat)](https://hex.pm/packages/exmorph/1.0.2)

## Usage

Add to your mix.exs:

`{:exmorph, "~> 1.0.1"}`

Use `import Exmorph` to enable the `~t` sigil which can be used to generate
an `%Exmorph.Tween{}`. The contents of the sigil are used to determine the
properties of the tween:

```elixir
iex> ~t(from 0 to 100 over 8sec ease quad_in)
%Exmorph.Tween{delta: 100, duration: 8000000000, easing: :quad_in,
 ends_at: 1494150596602924000, from: 0, started_at: 1494150588602924000,
 to: 100}
```

`~t` is just an alias for the `tween` function provided by `Exmorph`. You
could write the above as `Exmorph.tween("from 0 to 100 over 8sec ease quad_in")`
without the need to import `Exmorph`.

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
