maki.pack.add({ "https://github.com/eternasuno/maki-code" })

maki.setup({
  always_thinking = "adaptive",
  plugins = {
    task = {
      allow_model = true,
      max_concurrent = 4,
    },
    bash = {
      timeout_secs = 180,
    },
    index = {
      max_file_size_mb = 4,
    },
  },
})
