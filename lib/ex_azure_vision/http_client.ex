defmodule ExAzureVision.HttpClient do
  @moduledoc since: "0.1.0"
  @moduledoc """
  Http client for Azure vision.
  """

  @doc since: "0.1.0"
  @spec header_name :: String.t() | nil
  def header_name, do: Application.get_env(:ex_azure_vision, :header_name)

  @doc since: "0.1.0"
  @spec subscription_key :: String.t() | nil
  def subscription_key, do: Application.get_env(:ex_azure_vision, :subscription_key)

  @doc since: "0.1.0"
  @spec base_url :: String.t() | nil
  def base_url, do: Application.get_env(:ex_azure_vision, :base_url)

  @doc since: "0.1.0"
  @spec scheme :: String.t() | nil
  def scheme, do: Application.get_env(:ex_azure_vision, :scheme)

  @doc """
  Command for making http requests.

  ## Examples

      iex> path = "/vision/v3.2/analyze"
      iex> image_url = "https://example.gif/sample.jpg"
      iex> query_params = %{
      ...>   visualfeatures: "Categories,Adult,Tags,Description,Faces,Objects",
      ...>   details: "Landmarks"
      ...> }

      iex> HttpClient.test_request(path, image_url, query)
      {:ok,
        %{
          "adult" => %{
            "adultScore" => 0.005666189827024937,
            "goreScore" => 0.0019256346859037876,
            "isAdultContent" => false,
            "isGoryContent" => false,
            "isRacyContent" => false,
            "racyScore" => 0.00683207344263792
          },
          "categories" => [
            %{"name" => "abstract_", "score" => 0.0078125},
            %{"name" => "others_", "score" => 0.00390625}
          ],
          "description" => %{
            "captions" => [
              %{
               "confidence" => 0.2948395609855652,
               "text" => "a couple dogs sitting on a stone walkway"
              }
            ],
            "tags" => ["building", "ground", "way", "sidewalk", "stone", "cement",
            "tiled", "dirty"]
          },
          "faces" => [],
          "metadata" => %{"format" => "Jpeg", "height" => 1778, "width" => 800},
          "modelVersion" => "2021-05-01",
          "objects" => [
            %{
              "confidence" => 0.719,
              "object" => "dog",
              "parent" => %{
                "confidence" => 0.747,
                "object" => "mammal",
                "parent" => %{"confidence" => 0.748, "object" => "animal"}
              },
              "rectangle" => %{"h" => 171, "w" => 91, "x" => 427, "y" => 813}
            }
          ],
          "requestId" => "318058b0-01a9-4e78-9505-187b7ecdeada",
          "tags" => [
            %{"confidence" => 0.9823349714279175, "name" => "ground"},
            %{"confidence" => 0.9192745089530945, "name" => "building"},
            %{"confidence" => 0.9079620838165283, "name" => "animal"},
            %{"confidence" => 0.8770867586135864, "name" => "outdoor"},
            %{"confidence" => 0.8415917754173279, "name" => "flagstone"},
            %{"confidence" => 0.7894236445426941, "name" => "cat"},
            %{"confidence" => 0.7836271524429321, "name" => "floor"},
            %{"confidence" => 0.6647928953170776, "name" => "sidewalk"},
            %{"confidence" => 0.5628304481506348, "name" => "tile"}
          ]
        }
      }

  """
  @doc since: "0.1.3"
  @spec request(String.t(), String.t(), map()) :: {:ok, map()} | {:error, String.t()}
  def request(path, image_url, query) do
    url =
      %URI{
        scheme: scheme(),
        host: base_url(),
        port: 443,
        path: path,
        query: URI.encode_query(query)
      }

    response =
      %Req.Request{
        body: Jason.encode!(%{url: image_url}),
        method: :post,
        url: url
      }
      |> Req.Request.put_header(header_name(), subscription_key())
      |> Req.Request.put_header("content-type", "application/json")
      |> Req.Request.append_error_steps(retry: &Req.Steps.retry/1)
      |> Req.Request.run!()

    case response.status in 200..299 do
      true ->
        {:ok, Jason.decode!(response.body)}

      false ->
        {:error, Jason.decode!(response.body)["message"]}
    end
  end
end
