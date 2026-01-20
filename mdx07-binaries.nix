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
  ...
}:
stdenv.mkDerivation rec {
  pname = "mdx07-binaries";
  version = "0-unstable-2026-01-20";

  src = fetchurl {
    url = "https://git.chalmers.se/erik.sintorn/mdx07-binaries/-/archive/main/mdx07-binaries-main.tar.gz";
    sha256 = "sha256-tUsmYJha4p23ruu1IiXj1W7oYI8g+WWrlYMKuVgXwJY=";
  };

  nativeBuildInputs = [autoPatchelfHook];

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
    mkdir -p $out
    cp -R linux-x64/* $out/
  '';

  meta = with lib; {
    description = "Binaries (openocd, simserver, etc) that the MDx307 extension for VSCode requires to compile and run programs for the MD307 lab computer.";
    homepage = "https://git.chalmers.se/erik.sintorn/mdx07-binaries";
    license = licenses.unfree;
    platforms = ["x86_64-linux"];
    maintainers = [];
  };
}
