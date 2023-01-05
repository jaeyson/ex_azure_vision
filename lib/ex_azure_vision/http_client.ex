defmodule ExAzureVision.HttpClient do
  @moduledoc false

  def header_name, do: Application.get_env(:ex_azure_vision, :header_name)
  def subscription_key, do: Application.get_env(:ex_azure_vision, :subscription_key)
  def base_url, do: Application.get_env(:ex_azure_vision, :base_url)
  def scheme, do: Application.get_env(:ex_azure_vision, :scheme)
  def path, do: Application.get_env(:ex_azure_vision, :path)

  @doc false
  @spec request(String.t(), map(), String.t()) ::
          {:ok, response :: map()} | {:error, reason :: atom()}
  def request(image_url, query_params, service_path \\ "analyze") do
    path = [path(), service_path] |> Path.join()

    url =
      %URI{
        host: base_url(),
        scheme: scheme(),
        path: path,
        query: URI.encode_query(query_params)
      }
      |> URI.to_string()

    headers = [
      {
        String.to_charlist(header_name()),
        String.to_charlist(subscription_key())
      }
    ]

    content_type = 'application/json;'
    payload = Jason.encode!(%{url: image_url})

    request = {
      url,
      headers,
      content_type,
      payload
    }

    case :httpc.request(:post, request, [], []) do
      {:ok, {_status_code, _headers, response}} ->
        {:ok, Jason.decode!(response)}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
