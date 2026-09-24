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
      "commandcode/deepseek/deepseek-v4.1-flash",
      "commandcode/google/gemini-3.8-flash",
      "commandcode/meta/muse-spark-1.3-contributor",
      "commandcode/xiaomi/mimo-v2.6-pro",
      "openrouter/openrouter/free",
    },
  },
})
