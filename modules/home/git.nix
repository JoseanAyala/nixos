{ pkgs, ... }: {
  home.packages = [ pkgs.gh ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "JoseanAyala";
        email = "joseanayala@users.noreply.github.com";
      };

      # Use gh as the credential helper. The empty helper first clears any
      # inherited helpers, then the gh one is added.
      credential."https://github.com".helper = [ "" "!${pkgs.gh}/bin/gh auth git-credential" ];
      credential."https://gist.github.com".helper = [ "" "!${pkgs.gh}/bin/gh auth git-credential" ];
    };
  };
}
