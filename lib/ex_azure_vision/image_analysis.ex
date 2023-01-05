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
          "visualFeatures" => "Categories,Adult,Tags,Description,Faces,Objects",
          "details" => "Landmarks",
          "language" => "en",
          "model-version" => "latest"
        }

      iex> annotate_image(image_url, query_params)
      %{
        "categories" => [...],
        ...
      }
  """
  @doc since: "0.1.0"
  @spec analyze(String.t(), map()) :: {:ok, response :: map()} | {:error, reason :: atom()}
  def analyze(image_url, query_params) do
    HttpClient.request(image_url, query_params)
  end
end
