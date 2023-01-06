defmodule ExAzureVision.HttpClient do
  @moduledoc false
  # use Tesla

  def header_name, do: Application.get_env(:ex_azure_vision, :header_name)
  def subscription_key, do: Application.get_env(:ex_azure_vision, :subscription_key)
  def base_url, do: Application.get_env(:ex_azure_vision, :base_url)
  def scheme, do: Application.get_env(:ex_azure_vision, :scheme)

  @doc false
  def request(path, image_url, query) do
    url = %URI{
      scheme: scheme(),
      authority: base_url(),
      host: base_url(),
      port: 443,
      path: path,
      query: URI.encode_query(query)
    }

    body = Jason.encode!(%{url: image_url})
    options = [ssl: [{:versions, [:"tlsv1.2"]}], recv_timeout: 30_000]

    headers = [
      {"Content-Type", "application/json"},
      {header_name(), subscription_key()}
    ]

    request = HTTPoison.post(url, body, headers, options)

    case request do
      {:ok, response} ->
        {:ok, Jason.decode!(response.body)}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
