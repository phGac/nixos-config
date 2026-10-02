{ pkgs }:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "supabase-cli";
  version = "2.119.0";

  src = pkgs.fetchurl {
    url = "https://registry.npmjs.org/@supabase/cli-linux-x64/-/cli-linux-x64-${version}.tgz";
    hash = "sha256-FAitwGRJh69DyPTiYNx4DJ5zYltgwgDtWVehPde71EQ=";
  };

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin

    install -Dm755 package/bin/supabase \
      $out/bin/supabase

    install -Dm755 package/bin/supabase-go \
      $out/bin/supabase-go
  '';

  meta = {
    description = "Supabase CLI";
    homepage = "https://supabase.com/";
    mainProgram = "supabase";
  };
}
