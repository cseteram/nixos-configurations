{ config, ... }:

{
  imports = [
    ../../../secrets
  ];

  age.identityPaths = ["/etc/age/host-key"];
  age.rekey.hostPubkey = ../host-key.pub;

  age.secrets = {
    cloudflare-api-token = {
      rekeyFile = ../../../secrets/master/cloudflare-api-token.age;
      owner = config.services.caddy.user;
      group = config.services.caddy.group;
    };
    google-client-secret.rekeyFile = ../../../secrets/master/google-client-secret.age;
    immich-oidc-secret.rekeyFile = ../../../secrets/master/immich-oidc-secret.age;
    outline-oidc-secret = {
      rekeyFile = ../../../secrets/master/outline-oidc-secret.age;
      owner = config.services.outline.user;
      group = config.services.outline.group;
    };
  };
}
