{ lib, stdenv, fetchurl, libuuid, autoreconfHook }:

let version = "3.6.24"; in
stdenv.mkDerivation rec {
  pname = "reiserfsprogs";
  inherit version;

  src = fetchurl {
    url = "https://www.kernel.org/pub/linux/kernel/people/jeffm/reiserfsprogs/v${version}/${pname}-${version}.tar.xz";
    sha256 = "0q07df9wxxih8714a3mdp61h5n347l7j2a0l351acs3xapzgwi3y";
  };

  patches = [ ./reiserfsprogs-ar-fix.patch ];
  nativeBuildInputs = [ autoreconfHook ];
  buildInputs = [ libuuid ];

  NIX_CFLAGS_COMPILE = [ "-std=gnu90" "-D_GNU_SOURCE" ];

  meta = {
    inherit version;
    homepage = "http://www.namesys.com/";
    description = "ReiserFS utilities";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.linux;
  };
}
