{ lib, stdenv, autoreconfHook, pkg-config, SDL2, SDL2_mixer, SDL2_net
, fetchFromGitHub, fetchpatch, python3, incl }:

stdenv.mkDerivation {
  pname = "chocolate-doom";
  version = "3.0.1";

  src = ./.;

  patches = [
  ];

  outputs = [ "out" "man" ];

  postPatch = ''
    sed -e 's#/games#/bin#g' -i src{,/setup}/Makefile.am
    patchShebangs --build man/{simplecpp,docgen}
  '';

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
    # for documentation
    python3
  ];
  buildInputs = [ SDL2 SDL2_mixer SDL2_net ];
  enableParallelBuilding = true;

}
