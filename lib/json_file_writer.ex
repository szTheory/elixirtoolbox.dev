defmodule JsonFileWriter do
  @output_path "build/index.json"

  def write!(markdown_sections_list) do
    File.write!(@output_path, json(markdown_sections_list))
  end

  defp json(markdown_sections_list) do
    markdown_sections_list
    |> Jason.encode!()
  end
end
