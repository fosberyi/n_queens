defmodule NQueens do
  def solve(n) when is_integer(n) and n >= 0 do
    make_solution({n, []})
     |> Enum.map(&render(n, &1))
  end

  defp make_solution({n, positions}) when
    is_integer(n) and n >= 0 and length(positions) == n do
      [positions]
  end

  defp make_solution({n, positions}) when
    is_integer(n) and n >= 0 and is_list(positions) do
      possible_positions(n, positions)
        |> Enum.flat_map(fn {x, y} ->
          make_solution({n, [{x, y} | positions]})
        end) |> Enum.filter(fn val -> val != [] end)
  end

  defp render(n, solution) when is_list(solution) and n >= 0 do
    for y <- (0..n-1) do
      for x <- (0..n-1) do
        case solution |> Enum.member?({x,y}) do
          true -> "Q"
          false -> "0"
        end
      end
    end
  end

  defp possible_positions(n) when is_integer(n) and n >= 0 do
    for y <- 0..n-1,
        x <- 0..n-1,
        do: {x,y}
  end

  defp possible_positions(n, used_positions) when is_integer(n) and n >= 0 do
    blocked_positions = blocked_positions(n, used_positions)
    for y <- 0..n-1,
        x <- 0..n-1,
        !Enum.member?(blocked_positions, {x,y}),
        do: {x,y}
  end

  defp blocked_positions(n, used_positions) do
    used_positions
      |> Enum.flat_map(&blocked_position_for_position(n, &1))
      |> Enum.uniq
  end

  defp blocked_position_for_position(n, position) do
    (
     row_for(n, position) ++
     column_for(n, position) ++
     diag_for(n, position)
    ) |> Enum.uniq
  end

  defp row_for(n, {_x, y}) do
    for x <- 0..n-1, do: {x, y}
  end

  defp column_for(n, {x, _y}) do
    for y <- 0..n-1, do: {x, y}
  end

  defp diag_for(n, {x, y}) do
    for {px, py} <- possible_positions(n),
      abs(x-px) == abs(y-py),
      do: {px, py}
  end
end
