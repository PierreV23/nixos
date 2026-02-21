{ pkgs, secrets, ... }:
{
  systemd.tmpfiles.rules = [
    "C /root/.ssh/id_ed25519     0600 root root - ${pkgs.writeText "root-ssh-key" secrets.ssh.mediaserver.root.private_key}"
    "C /root/.ssh/id_ed25519.pub 0644 root root - ${pkgs.writeText "root-ssh-key-pub" secrets.ssh.mediaserver.root.public_key}"
  ];
}
