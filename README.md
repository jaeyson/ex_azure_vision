# ExAzureVision

Simple REST wrapper for using Azure's [Computer vision](https://learn.microsoft.com/en-us/azure/cognitive-services/computer-vision/)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_azure_vision` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_azure_vision, "~> 0.1.0"}
  ]
end
```

## Config

```elixir
# config/runtime.exs
config :ex_azure_vision,
  header_name: System.get_env("AZURE_OCP_APIM_HEADER_NAME"),
  subscription_key: System.get_env("AZURE_OCP_APIM_SUBSCRIPTION_KEY"),
  base_url: System.get_env("AZURE_COGNITIVE_VISION_BASE_URI"),
  scheme: "https",
  path: "/vision/v3.2"
```

## Analyze image

```elixir
iex> image_url = "https://images.unsplash.com/photo-1672676831425-207e5d4a0c41?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"

iex> query_params = %{
    "visualFeatures" => "Categories,Adult,Tags,Description,Faces,Objects",
    "details" => "Landmarks",
    "language" => "en",
    "model-version" => "latest"
  }

iex> ExAzureVision.analyze(image_url, query_params)
{:ok, ...}
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ex_azure_vision>.

