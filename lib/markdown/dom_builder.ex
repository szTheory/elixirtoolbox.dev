defmodule Markdown.DomBuilder do
  def html_from_markdown(markdown_text) do
    {:ok, html_doc, []} = Earmark.as_html(markdown_text)

    html_doc
  end
end
