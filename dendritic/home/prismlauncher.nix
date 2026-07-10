{
  flake.modules.homeManager.prismlauncher = { pkgs, ... }: {
    programs.prismlauncher = {
      enable = true;
      package = pkgs.prismlauncher.override {
        jdks = [
          pkgs.temurin-bin-25
          pkgs.temurin-bin-21
          pkgs.temurin-bin-17
          pkgs.temurin-bin-8
        ];
      };
    };
  };
}