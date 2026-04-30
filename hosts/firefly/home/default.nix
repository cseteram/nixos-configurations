{ config, pkgs, lib, ... }: {
  home = {
    stateVersion = "25.11";

    shell.enableZshIntegration = true;

    packages = with pkgs; [
      prismlauncher
      moonlight-qt
    ];

    file = {
      p10k = {
        enable = true;
        source = ./p10k.zsh;
        target = ".p10k.zsh";
      };
    };
  };

  programs = {
    home-manager.enable = true;

    alacritty = {
      enable = true;

      settings = {
        window.dimensions = {
          lines = 40;
          columns = 120;
        };
        window.padding = {
          x = 4;
          y = 4;
        };
        window.dynamic_padding = true;

        font = {
          normal = {
            family = "FiraCode Nerd Font";
          };
          size = 12;
        };
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        light = false;
        line-numbers = true;
        navigate = true;
        side-by-side = true;
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      ignores = [
        "*~"
        ".DS_Store"
      ];
    };

    nh = {
      enable = true;
      flake = "/Users/cseteram/nixos-configurations";

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
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config = lib.fileContents ./lsp.lua;
        }
      ];
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      plugins = [
        {
          name = "zsh-powerlevel10k";
          src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
          file = "powerlevel10k.zsh-theme";
        }
      ];

      initContent = lib.mkMerge [
        (
          lib.mkBefore ''
            if [[ -r "${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
              source "${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh"
            fi
          ''
        )
        (
          lib.mkAfter ''
            [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
          ''
        )
      ];
    };

    fzf = {
      enable = true;
    };
  };
}
