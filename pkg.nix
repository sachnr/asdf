{
  lib,
  stdenv,
}:
stdenv.mkDerivation rec {
  name = "rofi-wallpaper";

  src = lib.cleanSourceWith {
    filter = name: type: let
      baseName = baseNameOf (toString name);
    in
      ! (
        lib.hasSuffix ".nix" baseName
      );
    src = lib.cleanSource ./.;
  };

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/rofi/themes
    mkdir -p $out/share/rofi/script
    cp rofi/rofi-modi $out/share/rofi/script
    cp rofi/rofi-wallpaper $out/share/rofi/script
    cp rofi/wallpaper.rasi $out/share/rofi/themes
    substituteInPlace $out/share/rofi/script/rofi-wallpaper \
      --replace "script=./rofi-modi" "script=$out/share/rofi/script/rofi-modi" \
      --replace "theme=./wallpaper.rasi" "theme=$out/share/rofi/themes/wallpaper.rasi"

    sed -i "5 s%.*%CUR_DIR=$out/share/wallpapers%" $out/share/rofi/script/rofi-modi

    ln --symbolic $out/share/rofi/script/rofi-wallpaper $out/bin/rofi-wallpaper
  '';
}
