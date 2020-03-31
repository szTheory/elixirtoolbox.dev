defmodule ListItemHtmlParser do
  @moduledoc """
  Build hash representation of category from HTML row
  """

  alias Markdown.Section.BaseListItems
  alias Markdown.Section.ListItemTransformer

  @doc """
  Get a hash representation of the category parsed from HTML row
  """
  def hash_from_list_item_html(html) do
    list = base_list_items(html)
    category_name = category_name(html)
    entries = transform_base_list(list)

    %{name: category_name, entries: entries}
  end

  defp base_list_items(html) do
    BaseListItems.base_list_items(html)
  end

  defp category_name(html) do
    name =
      Regex.run(~r/\<li\>(.+)\<a/, html)
      |> Enum.at(1)
      |> String.trim()

    if name === "" do
      throw("Category name #{name} was empty for HTML #{html}")
    end

    name
  end

  defp transform_base_list(list) do
    ListItemTransformer.transform_base_list(list)
  end
end
