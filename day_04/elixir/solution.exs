"input.txt"
|> File.read!()
|> String.split("\n", trim: true)
|> Enum.reduce(0, fn
  <<_::binary-size(10), wins::binary-size(29), _::binary-size(3), scorecard::binary()>>, score ->
    wins =
      wins
      |> String.split(" ", trim: true)
      |> Map.new(&{&1, true})

    scorecard
    |> String.split(" ", trim: true)
    |> Enum.reduce(0, fn score, total ->
      case Map.get(wins, score, false) do
        true -> total + 1
        false -> total
      end
    end)
    |> then(fn
      0 -> 0
      1 -> 1
      match_count -> 2 ** (match_count - 1)
    end)
    |> Kernel.+(score)
end)
|> IO.puts()
