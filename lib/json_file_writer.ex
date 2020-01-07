defmodule JsonFileWriter do
  @output_path "build/index.json"

  def write! do
    File.write!(@output_path, json())
  end

  defp json do
    sections()
    |> Jason.encode!()
  end

  defp sections do
    Markdown.Sections.list()
  end
end
