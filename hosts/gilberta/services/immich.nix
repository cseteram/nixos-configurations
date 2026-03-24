{ config, lib, pkgs, ... }:

{
  services.immich = {
    enable = true;
  };

  services.caddy.virtualHosts."immich.cseteram.dev" = {
    extraConfig = ''
      reverse_proxy localhost:2283
    '';
  };
}
