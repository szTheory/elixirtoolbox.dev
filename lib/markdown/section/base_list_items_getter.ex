defmodule Markdown.Section.BaseListItems do
  def base_list_items(html) do
    list_item_anchors(html)
    |> list_items
  end

  defp list_item_anchors(html) do
    {:ok, document} = Floki.parse_document(html)
    Floki.find(document, "a")
  end

  defp list_items(anchors) do
    anchors
    |> Enum.map(&list_item(&1))
  end

  defp list_item(anchor) do
    {_, attrs, [name]} = anchor

    href =
      Enum.find_value(attrs, fn x ->
        {"href", url} = x
        url
      end)

    %{name: name, url: href}
  end
end
