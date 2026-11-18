{ ... }:
{
  flake.modules.nixos.memory =
    { ... }:
    {
      zramSwap = {
        enable = true;
        memoryPercent = 50;
      };

      systemd.oomd.enableUserSlices = true;
    };
}