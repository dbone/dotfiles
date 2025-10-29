-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("lspconfig").harper_ls.setup({
  settings = {
    ["harper-ls"] = {
      linters = {
        SentenceCapitalization = false,
        SpellCheck = false,
      },
    },
  },
})
