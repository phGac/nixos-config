{ pkgs, ... }:
let 
  modpack = pkgs.fetchModrinthModpack {
    url = "https://cdn.modrinth.com/data/4BV47HRn/versions/bdRIjRgs/Better%20MC%20%5BFORGE%5D%201.20.1%201.20.1%20v59.mrpack";
    packHash = "";
    side = "server";
  };
in
{
  services.minecraft-servers.servers.bettermc-1_20_1 = {
    enable = true;
    autoStart = false;

    # package = 

    
  }
}