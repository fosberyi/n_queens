defmodule NQueensTest do
  use ExUnit.Case
  test "1 queens includes a known solution" do
    possible_solution = [
      ~w(Q),
    ]

    result = NQueens.solve(1)

    assert Enum.member?(result, possible_solution)
  end

  test "4 queens includes a known solution" do
    possible_solution = [
      ~w(0 0 Q 0),
      ~w(Q 0 0 0),
      ~w(0 0 0 Q),
      ~w(0 Q 0 0),
    ]

    result = NQueens.solve(4)

    assert Enum.member?(result, possible_solution)
  end
end
