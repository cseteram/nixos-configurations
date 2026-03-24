{ config, lib, pkgs, ... }:

{
  services.outline = {
    enable = true;
    publicUrl = "https://outline.cseteram.dev";
    port = 56029;
    forceHttps = false;
    storage.storageType = "local";

    oidcAuthentication = {
      authUrl = "https://dex.cseteram.dev/auth";
      tokenUrl = "https://dex.cseteram.dev/token";
      userinfoUrl = "https://dex.cseteram.dev/userinfo";
      clientId = "outline";
      clientSecretFile = config.age.secrets.outline-oidc-secret.path;
      displayName = "Dex";
    };

    defaultLanguage = "ko_KR";
  };

  services.caddy.virtualHosts."outline.cseteram.dev" = {
    extraConfig = ''
      reverse_proxy localhost:56029
    '';
  };
}
