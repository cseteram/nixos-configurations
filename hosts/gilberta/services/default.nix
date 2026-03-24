{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./agenix.nix
      ./caddy.nix
      ./dex.nix
      ./immich.nix
      ./outline.nix
      ./samba.nix
    ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };
}
