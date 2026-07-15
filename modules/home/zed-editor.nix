{ pkgs, lib, ... }: {
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" ];
    userSettings = {
      languages = {
        Nix = {
          language_servers = [ "nil" "!nixd" ];
          formatter = {
            external = {
              command = "${lib.getExe pkgs.nixfmt-rfc-style}";
            };
          };
        };
      };
      lsp = {
        nil = {
          binary = {
            path = "${lib.getExe pkgs.nil}";
          };
        };
      };
    };
  };
}
