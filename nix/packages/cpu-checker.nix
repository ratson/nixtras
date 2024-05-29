{ stdenv, lib, fetchbzr, ... }:

stdenv.mkDerivation rec {
  pname = "cpu-checker";
  version = "41";

  src = fetchbzr {
    url = "lp:${pname}";
    rev = version;
    sha256 = "sha256-R5eSGUU3BR/XgtYXL0P31uVTmfwScFraduzR+GGsdA0=";
  };

  postPatch = ''
    substituteInPlace Makefile \
      --replace "/usr" "$out"
  '';

  meta = with lib; {
    homepage = "https://launchpad.net/cpu-checker";
    description = "Userspace tools for helping to evaluate the CPU (or BIOS) support for various features";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
