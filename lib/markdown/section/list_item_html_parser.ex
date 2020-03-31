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

    category_name =
      try do
        category_name(list)
      rescue
        BadMapError -> throw(html)
      end

    # category_name = category_name(list)
    entries = transform_base_list(list)

    %{name: category_name, entries: entries}
  end

  defp base_list_items(html) do
    BaseListItems.base_list_items(html)
  end

  defp category_name(base_list_items) do
    base_list_items
    |> List.first()
    |> Map.get(:name)
  end

  defp transform_base_list(list) do
    ListItemTransformer.transform_base_list(list)
  end
end
