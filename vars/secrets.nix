{ lib }:
{
  ssh.r7game.public_key = lib.trim (builtins.readFile ../secrets/ssh/r7game/pub);
  ssh.mediaserver.root.public_key = lib.trim (builtins.readFile ../secrets/ssh/mediaserver/root/pub);
  ssh.mediaserver.root.private_key = lib.trim (
    builtins.readFile ../secrets/ssh/mediaserver/root/priv
  );

  wg.mediaserver.public_key = lib.trim (builtins.readFile ../secrets/wg/mediaserver/pub);
  wg.mediaserver.private_key = lib.trim (builtins.readFile ../secrets/wg/mediaserver/priv);
  wg.eth.public_key = lib.trim (builtins.readFile ../secrets/wg/eth/pub);
  wg.eth.ip_port = lib.trim (builtins.readFile ../secrets/wg/eth/ip_port);
}
