return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Installed by Nix, not Mason. Mason tries to build nil_ls with Cargo,
        -- which is unnecessary and brittle on NixOS.
        nil_ls = {
          mason = false,
        },
      },
    },
  },
}
