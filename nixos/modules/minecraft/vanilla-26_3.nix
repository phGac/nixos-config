{ pkgs, lib, ... }:

{
  services.minecraft-servers.servers = {
    vanilla-26_3 = {
      enable = false;
      autoStart = false;

      package =
        pkgs.minecraftServers.vanilla-26_3.override {
          jre_headless = pkgs.openjdk25_headless;
        };

      openFirewall = true;
      jvmOpts = "-Xms2G -Xmx4G";

      serverProperties = {
        server-port = 25565;
        motd = "Minecraft Vanilla 26.3";
        max-players = 8;

        gamemode = "survival";
        difficulty = "hard";

        white-list = true;
        enforce-whitelist = true;

        online-mode = true;

        view-distance = 10;
        simulation-distance = 8;

        spawn-protection = 0;
      };

      whitelist = {
        "harstat" = "f6103fec-3bcd-4b13-8cae-1e83f1c68c88";
      };
    };
  };
}