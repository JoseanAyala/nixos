return {
  -- On NixOS, prefer language servers and tools from Nix/Home Manager.
  -- Mason downloads generic Linux binaries or builds tools with language package
  -- managers, which is often brittle on NixOS.
  { "mason-org/mason.nvim", enabled = false },
  { "mason-org/mason-lspconfig.nvim", enabled = false },
}
