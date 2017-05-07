defmodule Exmorph.Tween do
  defstruct delta: nil,
            duration: nil,
            easing: :linear,
            ends_at: nil,
            from: nil,
            started_at: nil,
            to: nil
end

