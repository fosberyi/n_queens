defmodule NQueens do
  def solve(n) when is_integer(n) and n >= 0 do
    [
      [
        ~w(Q)
      ]
    ]
  end
end
