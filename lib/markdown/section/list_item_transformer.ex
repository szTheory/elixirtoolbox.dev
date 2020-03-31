defmodule Markdown.Section.ListItemTransformer do
  @moduledoc """
  Clean up a library list item by transforming it from markdown
  into an Elixir data structure
  """

  alias Markdown.Section.ListItemLanguageParser
  alias Markdown.Section.ListItemNameParser

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
    list_item
    |> Map.put(:name, ListItemNameParser.parse_name(list_item))
    |> Map.put(:type, ListItemLanguageParser.parse_language(list_item))
  end
end
