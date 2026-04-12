{ lib, pkgs, config, inputs, self, ... }: {
  imports =
    [
      ./services
    ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # The platform the configuration will be used on.
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;

    overlays = [
      (_final: prev: {
        direnv = prev.direnv.overrideAttrs (_: {
          postPatch = ''
            substituteInPlace GNUmakefile --replace-fail " -linkmode=external" ""
          '';
        });
      })
    ];
  };

  networking = {
    computerName = "firefly";
    hostName = "firefly";
    localHostName = "firefly";
  };

  security.pam.services.sudo_local.touchIdAuth = true;
  security.sudo.extraConfig = "cseteram    ALL = (ALL) NOPASSWD: ALL";

  system = {
    primaryUser = "cseteram";

    defaults = {
      NSGlobalDomain = {
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
      };
      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "icnv";
        NewWindowTarget = "Home";
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      dock = {
        show-recents = false;
        persistent-apps = [
          { app = "/System/Applications/Calendar.app"; }
          { app = "/System/Applications/Weather.app"; }
          { app = "/System/Applications/Photos.app"; }
          { app = "/System/Applications/System Settings.app"; }
          { app = "/System/Cryptexes/App/System/Applications/Safari.app"; }
          { app = "/Applications/Discord.app"; }
          { app = "/Applications/1Password.app"; }
          { app = "/Users/cseteram/Applications/Home Manager Apps/Alacritty.app"; }
          { app = "/Applications/Windows App.app"; }
          { app = "/Users/cseteram/Applications/Home Manager Apps/Moonlight.app"; }
          { app = "/Users/cseteram/Applications/Home Manager Apps/PrismLauncher.app"; }
        ];
      };
      screencapture = {
        location = "/Users/cseteram/Downloads";
        type = "png";
        disable-shadow = true;
      };
    };
  };

  programs = {
    _1password.enable = true;
    _1password-gui.enable = true;
  };

  users.users.cseteram = {
    description = "Pyeongseok Oh";
    home = "/Users/cseteram";
    shell = pkgs.zsh;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.cseteram = import ./home;

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "cseteram";

    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };

    mutableTaps = false;
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    taps = builtins.attrNames config.nix-homebrew.taps;

    brews = [ ];
    casks = [
      "discord"
      "windows-app"
    ];
    masApps = { };
  };

  system = {
    # Set Git commit hash for darwin-version.
    configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 6;
  };
}
