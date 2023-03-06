{
  lib,
  stdenv,
  inputs,
}:
stdenv.mkDerivation rec {
  name = "wallpapers";

  src = inputs.wallpapers;

  installPhase = ''
    mkdir -p $out/wallpapers
    cp -r $src/* $out/wallpapers
  '';
}
