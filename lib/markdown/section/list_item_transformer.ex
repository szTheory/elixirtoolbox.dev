defmodule Markdown.Section.ListItemTransformer do
  def transform_base_list(list) do
    list
    |> Enum.map(fn x ->
      expand_list_item(x)
    end)
    |> Enum.filter(fn x ->
      String.trim(x.url) !== ""
    end)
  end

  defp expand_list_item(list_item) do
    name = Map.get(list_item, :name)
    type = if Regex.match?(~r/\[erl/, name), do: :erlang, else: :elixir
    num = num_from_name(name)
    url = Map.get(list_item, :url)

    list_item
    |> Map.put(:name, name_for_url(url))
    |> Map.put(:type, type)
    |> Map.put(:num, String.to_integer(num))
  end

  defp name_for_url(url) do
    can_infer_name =
      ["github.com", "hex.pm", "gitlab.com", "bitbucket.org", "gitgud.io"]
      |> Enum.any?(&String.contains?(url, &1))

    if can_infer_name do
      url
      |> String.replace(~r/\/+$/, "")
      |> String.split("/")
      |> List.last()
    else
      url
    end
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
