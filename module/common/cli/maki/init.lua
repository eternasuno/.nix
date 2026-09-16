maki.setup({
  always_thinking = "high",
  plugins = {
    task = {
      allow_model = true,
    },
    bash = {
      timeout_secs = 180,
    },
    index = {
      max_file_size_mb = 4,
    },
  },
  provider = {
    allowed_models = {
      "openai/gpt-5.6*",
      "openrouter/openrouter/free",
    },
  },
})
