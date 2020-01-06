defmodule HtmlFileWriter do
  @template_path "index.eex"
  @output_path "build/index.html"

  def write! do
    File.write!(@output_path, html())
  end

  defp html do
    EEx.eval_file(@template_path, assigns: [sections: sections()])
  end

  defp sections do
    val = Markdown.Sections.list()
    val |> IO.inspect()
    val
  end
end
