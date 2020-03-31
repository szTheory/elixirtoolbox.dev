defmodule Markdown.Section.ListCleaner do
  @moduledoc """
  Clean up the list of libraries within a section by transforming
  them from the individual markdown list item into an Elixir data structure
  """

  # TODO: alphabetically sort by category name within each section

  def hashify_section_list(raw_section_list) do
    raw_section_list
    |> clean_section_list
    |> Enum.map(fn markdown_list_item ->
      hash_from_markdown_list_item(markdown_list_item)
      # throw(val)
    end)
    |> List.flatten()

    # |> Enum.sort(fn list_item ->
    #   throw(list_item)
    # end)
  end

  defp clean_section_list(raw_section_list) do
    section_rows(raw_section_list)
    |> reject_blank
  end

  # TODO: sort by language within each list item
  defp hash_from_markdown_list_item(markdown_list_item) do
    {:ok, html, _} = Earmark.as_html(markdown_list_item)

    html
    |> ListItemHtmlParser.hash_from_list_item_html()
  end

  defp section_rows(raw_section_list) do
    raw_section_list
    |> String.split("\n")
  end

  defp reject_blank(section_rows) do
    section_rows
    |> Enum.reject(&(String.trim(&1) == ""))
  end
end
