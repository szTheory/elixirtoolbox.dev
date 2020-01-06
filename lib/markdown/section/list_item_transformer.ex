defmodule Markdown.Section.ListItemTransformer do
  def transform_base_list(list, category_name) do
    Enum.map(list, fn x ->
      expand_list_item(category_name, x)
      |> Map.delete(:name)
    end)
  end

  defp expand_list_item(category_name, list_item) do
    name = Map.get(list_item, :name)
    type = if Regex.match?(~r/\[erl/, name), do: :erlang, else: :elixir
    num = num_from_name(name)

    list_item
    |> Map.put(:name, category_name)
    |> Map.put(:type, type)
    |> Map.put(:num, String.to_integer(num))
  end

  def num_from_name(name) do
    if is_num(name) do
      name
      |> String.replace(~r/\[(\d)\]/, "\\g{1}")
      |> String.trim()
    else
      "1"
    end
  end

  def is_num(name) do
    Regex.match?(~r/\[(\d)\]/, name)
  end
end
