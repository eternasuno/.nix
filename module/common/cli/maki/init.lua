maki.setup({
  always_thinking = "adaptive",
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
      "cpa*",
      "openai/gpt-5.6-*",
      "openai/gpt-6-*",
      "openrouter/openrouter/free",
    },
  },
})
