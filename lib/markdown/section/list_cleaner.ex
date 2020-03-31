defmodule Markdown.Section.ListCleaner do
  @moduledoc """
  Clean up the list of libraries within a section by transforming
  them from the individual markdown list item into an Elixir data structure
  """

  # TODO: alphabetically sort by category name within each section
  # TODO: sort by language within each list item
  def hashify_section_list(raw_section_list) do
    # {:ok, html_doc, []} = Earmark.as_html(section_list)
    # html_doc
    raw_section_list
    |> clean_section_list
    |> Enum.map(fn x ->
      {:ok, html, _} = Earmark.as_html(x)

      html
      |> ListItemHtmlParser.hash_from_list_item_html()
    end)
    |> List.flatten()
  end

  defp clean_section_list(raw_section_list) do
    section_rows(raw_section_list)
    |> reject_blank
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
