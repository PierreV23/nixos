{ secrets, ... }:
{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "prohibit-password";
  };
  users.users.root = {
    hashedPassword = secrets.nova.root_password;
    openssh.authorizedKeys.keys = [
      secrets.ssh.r7game.public_key
    ];
  };
}