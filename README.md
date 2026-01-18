# ExAzureVision

Simple REST wrapper for using Azure's [Computer vision](https://learn.microsoft.com/en-us/azure/cognitive-services/computer-vision/)

**Note**: the only place where ai is used/integrated is in PR reviews. I am NOT interested in adding/integrating ai generated code in my codebase, as this little library can be fit in my mental model. ai has it’s own great use case, it’s just that I wanted to be hands-on with these projects.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_azure_vision` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_azure_vision, "~> 0.1"}
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
  scheme: "https"
```

## Analyze image

```elixir
iex> image_url = "https://images.unsplash.com/photo-1672676831425-207e5d4a0c41?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"

iex> query_params = %{
    visualfeatures: "Categories,Adult,Tags,Description,Faces,Objects",
    details: "Landmarks"
  }

iex> ExAzureVision.analyze(image_url, query_params)
{:ok,
 %{
   "adult" => %{
     "adultScore" => 0.002399180782958865,
     "goreScore" => 9.791345801204443e-4,
     "isAdultContent" => false,
     "isGoryContent" => false,
     "isRacyContent" => false,
     "racyScore" => 0.003331553190946579
   },
   "categories" => [
     %{
       "detail" => %{"landmarks" => []},
       "name" => "outdoor_",
       "score" => 0.00390625
     },
     %{
       "detail" => %{"landmarks" => []},
       "name" => "outdoor_street",
       "score" => 0.6953125
     }
   ],
   "description" => %{
     "captions" => [
       %{
         "confidence" => 0.4641128182411194,
         "text" => "a red motorcycle parked on a sidewalk"
       }
     ],
     "tags" => ["building", "outdoor", "way", "ground", "sidewalk", "parked",
      "brick", "scene", "street", "red", "scooter", "stone", "curb"]
   },
   "faces" => [],
   "metadata" => %{"format" => "Jpeg", "height" => 1031, "width" => 687},
   "modelVersion" => "2021-05-01",
   "objects" => [
     %{
       "confidence" => 0.685,
       "object" => "Tire",
       "parent" => %{"confidence" => 0.69, "object" => "Wheel"},
       "rectangle" => %{"h" => 120, "w" => 94, "x" => 299, "y" => 758}
     },
     %{
       "confidence" => 0.836,
       "object" => "motorcycle",
       "parent" => %{
         "confidence" => 0.837,
         "object" => "cycle",
         "parent" => %{
           "confidence" => 0.839,
           "object" => "Land vehicle",
           "parent" => %{"confidence" => 0.839, "object" => "Vehicle"}
         }
       },
       "rectangle" => %{"h" => 377, "w" => 264, "x" => 231, "y" => 502}
     }
   ],
   "requestId" => "6b771571-3a09-4e25-a1f2-281e4afd9601",
   "tags" => [
     %{"confidence" => 0.9982832074165344, "name" => "building"},
     %{"confidence" => 0.9925278425216675, "name" => "outdoor"},
     %{"confidence" => 0.97878497838974, "name" => "vehicle"},
     %{"confidence" => 0.9700937271118164, "name" => "motorcycle"},
     %{"confidence" => 0.9631041288375854, "name" => "tire"},
     %{"confidence" => 0.9608349204063416, "name" => "land vehicle"},
     %{"confidence" => 0.9542198777198792, "name" => "wheel"},
     %{"confidence" => 0.9527726173400879, "name" => "brick"},
     %{"confidence" => 0.9033293724060059, "name" => "window"},
     %{"confidence" => 0.8922328352928162, "name" => "red"},
     %{"confidence" => 0.8901116251945496, "name" => "parked"},
     %{"confidence" => 0.8846046924591064, "name" => "auto part"},
     %{"confidence" => 0.8454196453094482, "name" => "road"},
     %{"confidence" => 0.8162581920623779, "name" => "ground"},
     %{"confidence" => 0.7266983389854431, "name" => "street"},
     %{"confidence" => 0.6291871666908264, "name" => "scooter"},
     %{"confidence" => 0.587371289730072, "name" => "sidewalk"},
     %{"confidence" => 0.5613589286804199, "name" => "house"}
   ]
 }
}
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ex_azure_vision>.

