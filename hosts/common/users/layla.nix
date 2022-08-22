{ pkgs, config, ... }:
{
  users.mutableUsers = false;
  users.users.layla = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ];
    passwordFile = config.sops.secrets.layla-password.path;
  };

  sops.secrets.layla-password = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };

}
