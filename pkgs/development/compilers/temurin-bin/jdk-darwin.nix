{ lib, callPackage }:

let
  sources = (lib.importJSON ./sources.json).hotspot.mac;
  common = opts: callPackage (import ./jdk-darwin-base.nix opts) {};
in
{
  jdk-8 = common { sourcePerArch = sources.jdk.openjdk8; };
  jre-8 = common { sourcePerArch = sources.jre.openjdk8; };
  jdk-11 = common { sourcePerArch = sources.jdk.openjdk11; };
  jre-11 = common { sourcePerArch = sources.jre.openjdk11; };
  jdk-16 = common { sourcePerArch = sources.jdk.openjdk16; };
  jdk-17 = common { sourcePerArch = sources.jdk.openjdk17; };
}
