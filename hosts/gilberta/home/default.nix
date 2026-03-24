{ config, pkgs, lib, ... }: {
  home = {
    stateVersion = "25.11";
  };

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
    };
    
    nh = {
      enable = true;
      flake = "/home/cseteram/nixos-config";

      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 10 --keep-since 7d";
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      plugins = with pkgs.vimPlugins; [
        editorconfig-vim
        fzf-vim
      ];
    };
  };
}
