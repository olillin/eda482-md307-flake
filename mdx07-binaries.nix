{
  stdenv,
  lib,
  fetchurl,
  autoPatchelfHook,
  glib,
  gtk3,
  libx11,
  libxxf86vm,
  libsm,
  libxkbcommon,
  cairo,
  gdk-pixbuf,
  pango,
  fontconfig,
  libusb1,
  makeDesktopItem,
  imagemagick,
  ...
}: let
  hash = "2597eab47fe4a58a1392c682976a1b04a23b7462";

  desktopItem = makeDesktopItem {
    name = "simserver";
    desktopName = "Simserver";
    icon = "simserver";
    exec = "simserver";
  };
in
  stdenv.mkDerivation rec {
    pname = "mdx07-binaries";
    version = "0-unstable-2026-01-20";

    src = fetchurl {
      url = "https://git.chalmers.se/erik.sintorn/mdx07-binaries/-/archive/${hash}/mdx07-binaries-main.tar.gz";
      sha256 = "sha256-uKw8r1KC3QWp9bFy8YmJcl/9FC5z6Ssv3BAfmzl1CMQ=";
    };

    nativeBuildInputs = [autoPatchelfHook imagemagick];

    buildInputs = [
      stdenv.cc.cc.lib
      glib
      gtk3
      libx11
      libxxf86vm
      libsm
      libxkbcommon
      cairo
      gdk-pixbuf
      pango
      fontconfig
      libusb1
    ];

    # Only the linux‑x64 dir is needed for x86_64‑linux
    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      cp -R linux-x64/* $out/bin/

      runHook postInstall
    '';

    postInstall = ''
      install -m 444 -D "${desktopItem}/share/applications/"* \
        -t $out/share/applications/
      for size in 16 24 32 48 64 128; do
        mkdir -p $out/share/icons/hicolor/"$size"x"$size"/apps
        convert -background none -resize "$size"x"$size" ${./simserver.png} $out/share/icons/hicolor/"$size"x"$size"/apps/simserver.png
      done
    '';

    meta = with lib; {
      description = "Binaries (openocd, simserver, etc) that the MDx307 extension for VSCode requires to compile and run programs for the MD307 lab computer.";
      homepage = "https://git.chalmers.se/erik.sintorn/mdx07-binaries";
      license = licenses.unfree;
      platforms = ["x86_64-linux"];
      maintainers = [];
    };
  }
