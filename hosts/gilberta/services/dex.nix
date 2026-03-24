{ config, lib, pkgs, ... }:

{
  services.dex = {
    enable = true;
    environmentFile = config.age.secrets.google-client-secret.path;
    settings = {
      issuer = "https://dex.cseteram.dev";
      storage.type = "sqlite3";
      web.http = "localhost:5556";

      connectors = [{
        type = "oidc";
        id = "google";
        name = "Google";
        config = {
          issuer = "https://accounts.google.com";
          clientId = "$GOOGLE_CLIENT_ID";
          clientSecret = "$GOOGLE_CLIENT_SECRET";
          redirectURI = "https://dex.cseteram.dev/callback";
          promptType = "";
        };
      }];

      staticClients = [
        {
          id = "immich";
          secretFile = config.age.secrets.immich-oidc-secret.path;
          name = "Immich";
          redirectURIs = [
            "https://immich.cseteram.dev/auth/login"
            "app.immich:///oauth-callback"
          ];
        }
        {
          id = "outline";
          secretFile = config.age.secrets.outline-oidc-secret.path;
          name = "Outline";
          redirectURIs = [
            "https://outline.cseteram.dev/auth/oidc.callback"
          ];
        }
      ];
    };
  };

  services.caddy.virtualHosts."dex.cseteram.dev" = {
    extraConfig = ''
      reverse_proxy localhost:5556
    '';
  };
}
