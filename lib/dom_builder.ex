defmodule DomBuilder do
  def build(markdown_text) do
    {:ok, html_doc, []} = Earmark.as_html(markdown_text)

    html_doc
  end
end
