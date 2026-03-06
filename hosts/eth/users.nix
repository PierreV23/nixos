{secrets, ...}:
{
  users.users.root = {
    hashedPassword = secrets.eth.root_password;
    openssh.authorizedKeys.keys = [
        secrets.ssh.r7game-wsl.nixos.public_key
        secrets.ssh.t480s.public_key
    ];
  };
}