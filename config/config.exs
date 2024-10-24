import Config

if Mix.env() in [:dev, :test] do
  config :ex_azure_vision,
    header_name: System.get_env("AZURE_OCP_APIM_HEADER_NAME"),
    subscription_key: System.get_env("AZURE_OCP_APIM_SUBSCRIPTION_KEY"),
    base_url: System.get_env("AZURE_COGNITIVE_VISION_BASE_URI"),
    scheme: "https"
end
