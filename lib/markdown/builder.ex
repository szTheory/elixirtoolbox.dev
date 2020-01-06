defmodule Markdown.Builder do
  @text_after_header "## General Libraries"
  @text_footer_start "---"

  def build_markdown do
    readme_text()
    |> without_header
    |> without_footer
    |> String.trim()
  end

  defp readme_text do
    ReadmeDownloader.download()
  end

  defp without_header(readme_text) do
    [_ | remaining_text] =
      readme_text
      |> String.split(@text_after_header)

    [@text_after_header, remaining_text]
    |> Enum.join()
  end

  defp without_footer(readme_text) do
    [text_before_footer | _] =
      readme_text
      |> String.split(@text_footer_start)

    text_before_footer
  end
end
