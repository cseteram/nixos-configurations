{ config, lib, pkgs, ... }:

{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        workgroup = "WORKGROUP";
        "server string" = "gilberta";
        "valid users" = "cseteram";
        "vfs objects" = "catia fruit streams_xattr";
        "fruit:metadata" = "stream";
        "fruit:model" = "MacSamba";
        "fruit:posix_rename" = "yes";
        "fruit:veto_appledouble" = "no";
      };
      nas = {
        path = "/data/shared";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
      };
    };
  };
}
