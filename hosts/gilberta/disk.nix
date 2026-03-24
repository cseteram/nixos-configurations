{ config, lib, pkgs, modulesPath, ... }:

{
  boot.supportedFilesystems = ["zfs"];
  boot.zfs = {
    forceImportRoot = false;
    extraPools = ["data"];
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/88fb2583-1ad1-44bd-8f6e-4b3d932cab37";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/35F4-7ABC";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/239979de-eef1-451f-bcea-c15a68398459"; }
    ];
}
