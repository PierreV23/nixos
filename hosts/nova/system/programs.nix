{pkgs,...}:
{
    environment.systemPackages = [ pkgs.curl pkgs.git ];
}