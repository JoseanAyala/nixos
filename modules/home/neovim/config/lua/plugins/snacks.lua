-- Snacks.nvim picker/explorer overrides
return {
  {
    "folke/snacks.nvim",
    opts = {
      scroll = { enabled = false },
      indent = {
        animate = {
          enabled = false,
        },
      },
      picker = {
        hidden = true,
        focus = "list",
        sources = {
          explorer = {
            git_status_live = true,
            ignored = true,
          },
        },
      },
    },
  },
}
