defmodule HtmlFileWriter do
  @template_path "index.eex"
  @output_path "build/index.html"

  def write!(markdown_sections_list) do
    File.write!(@output_path, html(markdown_sections_list))
  end

  defp html(markdown_sections_list) do
    EEx.eval_file(@template_path, assigns: [sections: markdown_sections_list])
  end
end
