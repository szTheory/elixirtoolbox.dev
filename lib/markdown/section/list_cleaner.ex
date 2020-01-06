defmodule Markdown.Section.ListCleaner do
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
    raw_section_list
    |> String.split("\n")
    |> Enum.map(&String.replace(&1, ~r/^\- (.+)$/, "\\g{1}"))
    |> Enum.reject(&(String.trim(&1) == ""))
  end
end
