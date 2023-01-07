defmodule ExAzureVision.ImageAnalysis do
  @moduledoc since: "0.1.0"
  @moduledoc """
  Module for analyzing image.
  """

  alias ExAzureVision.HttpClient

  @doc """
  Analyzes the image using url. Returns Jason decoded value or error message.

  ## Examples
      image_url = "https://example.gif/sample.jpg"

      query_params =
        %{
          visualfeatures: "Categories,Adult,Tags,Description,Faces,Objects",
          details: "Landmarks"
        }

      iex> annotate_image(image_url, query_params)
      %{
        "categories" => [...],
        "description" => [...],
        ...
      }
  """
  @doc since: "0.1.0"
  def analyze(image_url, query) do
    path = "/vision/v3.2/analyze"
    HttpClient.request(path, image_url, query)
  end
end
