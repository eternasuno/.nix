require("review")

maki.setup({
  always_thinking = "high",

  provider = {
    default_model = "openai/gpt-5.6-luna",
    allowed_models = {
      "openai/gpt-5.6*",
      "opencode/*-free",
      "opencode-go/*",
      "openrouter/google/gemini-3.7-flash",
      "openrouter/openrouter/free",
    },
  },

  plugins = {
    task = {
      max_concurrent = 8,
    },

    bash = {
      timeout_secs = 180,
    },

    index = {
      max_file_size_mb = 4,
    },
  },
})
