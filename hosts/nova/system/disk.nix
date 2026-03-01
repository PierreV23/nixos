{ ... }:
{
  fileSystems."/mnt/data" = {
    device = "/dev/vdb";
    fsType = "ext4";
    options = [ "defaults" "nofail" ];
  };
}