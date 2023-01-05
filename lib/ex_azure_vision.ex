defmodule ExAzureVision do
  @moduledoc since: "0.1.0"
  @moduledoc """
  Public API functions to interact with Azure Computer Vision.
  """

  defdelegate analyze(image_url, query_params), to: ExAzureVision.ImageAnalysis
end
