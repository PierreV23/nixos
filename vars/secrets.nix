{ lib }:
{
  ssh.r7game.public_key = lib.trim (builtins.readFile ../secrets/ssh/r7game/pub);
  ssh.mediaserver.root.public_key = lib.trim (builtins.readFile ../secrets/ssh/mediaserver/root/pub);
  ssh.mediaserver.root.private_key = lib.trim (
    builtins.readFile ../secrets/ssh/mediaserver/root/priv
  );
}
