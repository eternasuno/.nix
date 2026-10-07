maki.pack.add({ "https://github.com/eternasuno/maki-kanban", "https://github.com/eternasuno/maki-code" })

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
      "openai/gpt-6*",
      "commandcode/*",
      "openrouter/openrouter/free",
    },
  },
})
