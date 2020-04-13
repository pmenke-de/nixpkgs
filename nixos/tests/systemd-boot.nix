{ system ? builtins.currentSystem,
  config ? {},
  pkgs ? import ../.. { inherit system config; }
}:

with import ../lib/testing-python.nix { inherit system pkgs; };
with pkgs.lib;

let
  PkKek-snakeoil-crt = builtins.toFile "PkKek-snakeoil.crt" ''
    -----BEGIN CERTIFICATE-----
    MIIFFTCCAv2gAwIBAgIURa9HsoF5yFxGoMniLXtULYpK+xowDQYJKoZIhvcNAQEL
    BQAwGjEYMBYGA1UEAwwPbXkgUGxhdGZvcm0gS2V5MB4XDTIwMDQxMjIwNDQwM1oX
    DTMwMDQxMDIwNDQwM1owGjEYMBYGA1UEAwwPbXkgUGxhdGZvcm0gS2V5MIICIjAN
    BgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA6MmD15/p+3rDblgDPS7Ciz7QVFiG
    7y1Sw5kC1b1oyXK8J5reQfTXZWddes8jDeuELDK0WEy+9AJQQXmivB8K6Jyl+wTw
    2zYriMAhkpyz5kdIAob3wGOU/rhCBriT8dECtTiw/t+dTgU2Iy73tDQkkJdwh/l8
    J+QQaAPkGTMAkZT+U4WFmi6Bvz9aRVqwgk6dW1ghlEKcfguGdtSiUXVEsSIjfZBK
    vgTfdvyDm/VhAaSw3bpmPNk+fqMzK7iwOpCdLM58DA3uonYUHYv7UzGnT4Qvg9CK
    4ETEh6a/iCt348Y1LB10cW1Qkt/nNE8x51Ltew5LaiLR7lSErKUQwL7yMaJAabWb
    Y5+dcahxO7SsaxIgNB6MfumvR6vTpMiYGhTtq0PZLiSBdCpHx0r5Kw30WQeSJKf3
    FQiD3SStfuNlTqFMutCjXjaigI4nbFL2kQRJEIb6lSxQAhW1EfNVqhcCUUHE/QEV
    ojf5Zkea5+SXFnC/0tWqs09dZ2jggWgyupajb74+NgJ26GI02DiYYAEU6BCw4gNq
    mmOrqB0lVAXo3BI7WLC+gJPex6efEHw61doXpLrKPzczhpUv3dqbtt0QGyLA+mFG
    e0z3l74CtziwzCB/UTQGuynDDY8iZwh6J4uYJ5mV5bUXyTsXIgPQME33rExjx28d
    N+J/6TszqFNVUbMCAwEAAaNTMFEwHQYDVR0OBBYEFEEzlNfvsbDPka2xTsLKhfeP
    bmHnMB8GA1UdIwQYMBaAFEEzlNfvsbDPka2xTsLKhfePbmHnMA8GA1UdEwEB/wQF
    MAMBAf8wDQYJKoZIhvcNAQELBQADggIBAENbDwsx+dbeY4r3Rdi7bkLK5tfYLq2l
    lZ6n1KK6wKphTood14LHnyxYWdVw7Pz3CaLVnhrqHe0tt6KTA6CanA6c5PV25aFd
    6Oo1ddTApmwJmFj9e63tH6/CviVr+iyNwMGisUs9HP6Pt1J1+9pYIfe4/X6VXPgA
    //8ckImtJ/pvCJJu1xoC+YZ1MoaMRdyPK6MsAAcRdMdZ7QOKaImr+h0iy3yK8eAM
    8/lumGjivvNCvMGHYfpM0taMll8gHC8tYIELXGkauDe7s9aCLUAJCa0NhfROifVT
    Ix6CQ+FjS+R0orV8Iu7KjZTG9Dk6VPLgVMvtahmbYMhaxZlFt15ogosEOYeLWC4b
    uUh4uyBmHCqevqOM+5SodcKuZMUT+02Xx+U08IZLGMPl8+MZf1QxCsmRHw3W3hbC
    iKINkdcwEhUuYJaVYUP7yxm7Gbx2qPwQ8up4LqOMsYH3NXGcq4Qglq9vzSa8bYsY
    hP4ou9jHmpBYmlFYCqc6uUiTfjWf5D2k3VAujBTyHBAsHEzZa2Ycsjf9L8LSfHfk
    2IoNhdgrqy0HoEenJy2WokXMYAs2uj49yA065Tk0J9/gB2Pecz0xDyt/LVRbbao8
    /Gg+meU+hGuLxY11C+qEHN/NCzTmCflBUkRlb26dA5wRT8ITAEcgajhLMaSa+v57
    2e6EmepY97+U
    -----END CERTIFICATE-----
  '';

  PkKek-snakeoil-key = builtins.toFile "PkKek-snakeoil.key" ''
    -----BEGIN PRIVATE KEY-----
    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
    HqttWdLXTduWjw9AiomZDMNVLFVa9AMxLIXZX4B/u5fgfQSQ87Ogp0NaBab09A7r
    nWt4pHoBQqRXhHsbfYLinp22Y+/R9ffXq6D/uGLOgTt+uBVDK9/imOE7oKHcqhtV
    HFkt/9m6UUI2kqA2rl921pYOKDZSMkBb6Im666Ml8QKCAQAG5cf3DYW78unp/X/j
    CNf4MNaDDRLbUUl4EOdzvpWimn7mSIV3yUBx82/KMLi7UGWDHAXyvlo4u6mEhfTj
    FepY8j6TNI2efSR30uQGE/l2vZvOggVSnHvzQ3KU2w4FZsqNvzjGaeZ0+LWpfUhW
    dTubSqJAkhtZFOyib9m+O6QyhEzikHcLK0bMabJS5jQWeSjpeaY5NbXPDCb5HiE5
    Tv4j9K78+1LSpPkZLW2cWwM4Lq2OItKaPDQL1ZIxqQImS1NGCM/6cXpVx1OQ5XjC
    r+cP3Eosdw+HxT27sZLIp1l6LDlgQ1uiyShPkZl3bvbJYj8vtrqYMFw75igWPeiR
    6U55AoIBAQDktxTEzfZuPV8NHPlQsrDlLXShjnqZ0H/xtlQtUxV9IjmnL0UNI/Sw
    lY7+V1jU/p9aGn3vJ0LHbOXBpJ6uQSJzGao7Ek3GX0qp2zqordLt3pOBI/5t7cib
    aItZMOwiWDQnX4kn5qxHFLhF4HM19vXa2W/jm4HEIw8kbAKAqSps7uTBNDw5oD4Z
    BSYnhiKc+mtSLJxI6jhQeY7nm0k/4J/t5oRGvvY4jvw8DuUd+ifcRQWaXN4khiUH
    i3dWC32Pc+1DWMFA2z5gI9APkUXqRv9oDUBZWqUpjWiBZuik/MvExrDzxZuuf0/k
    xy864g7hXEQ7UPBoP8uNZT+gtu5urtik
    -----END PRIVATE KEY-----
  '';

  # TODO: It probably doesn't need to be OVMF-secureBoot here
  shellImg = pkgs.runCommand "shell.img" { nativeBuildInputs = [ pkgs.qemu ]; } ''
    mkdir -p $out ./vfat-root/efi/boot
    cp ${pkgs.OVMF-secureBoot}/X64/EnrollDefaultKeys.efi vfat-root/EnrollDefaultKeys.efi
    cp ${pkgs.OVMF-secureBoot}/X64/Shell.efi vfat-root/efi/boot/bootx64.efi

    qemu-img convert --image-opts \
      driver=vvfat,floppy=on,fat-type=12,label=UEFI_SHELL,dir=./vfat-root \
      $out/shell.img
  '';

  # TODO: Use make-iso9660-image.nix ?
  UefiShell = pkgs.runCommand "UefiShell.iso" { nativeBuildInputs = [ pkgs.xorriso ]; } ''
    xorriso --as mkisofs -input-charset ASCII -J -rational-rock \
      -e shell.img -no-emul-boot -o $out ${shellImg}
  '';

  # TODO: Move this into pkgs?
  ovmf-vars-generator = pkgs.stdenv.mkDerivation {
    pname = "ovmf-vars-generator";
    version = "2019-12-10";

    src = pkgs.fetchFromGitHub {
      owner = "rhuefi";
      repo = "qemu-ovmf-secureboot";
      rev = "c3e16b359661410f8c31e0af1279cbec4ed6fc1f"; # 2019-12-10
      sha256 = "1a8lqy1wdqicsqpsxndxrr1jakm430qbc0yjzmxf25zicjipablm";
    };

    patches = [
      (pkgs.fetchpatch {
        url = "https://salsa.debian.org/qemu-team/edk2/-/raw/54927fd67d8e8a35164554a0de0e1487c601b12d/debian/patches/ovmf-vars-generator-no-defaults.patch";
        sha256 = "1dk3hhfn4cqyr7jfd7c313mvr0wfbly1pazdf5dnq1x8zbgdr6nv";
      })
    ];

    patchFlags = "-p2";

    buildInputs = [ (pkgs.python3.withPackages (p: with p; [ requests ])) ];

    installPhase = ''
      mkdir -p $out/bin
      cp ovmf-vars-generator $out/bin
    '';
  };

  # Much of this was cribbed from debian/rules for ovmf package
  # TODO: Investigate smm (should we disable this in the test?)
  ovmf-vars-enroll = pemFile: pkgs.runCommand "OVMF_VARS.fd" { nativeBuildInputs = [ pkgs.qemu pkgs.python3 ]; } ''
    OEM_STRING=$( \
      tr -d '\n' < ${pemFile} | \
        sed \
        -e 's/.*-----BEGIN CERTIFICATE-----/4e32566d-8e9e-4f52-81d3-5bb9715f9727:/' \
        -e 's/-----END CERTIFICATE-----//' \
    )
    cp ${pkgs.OVMF-secureBoot.fd}/FV/OVMF_VARS.fd .
    chmod 644 OVMF_VARS.fd

    ${ovmf-vars-generator}/bin/ovmf-vars-generator \
      --qemu-binary ${pkgs.qemu}/bin/qemu-system-x86_64 \
      --print-output \
      --disable-smm \
      --no-default \
      --skip-testing \
      --oem-string $OEM_STRING \
      --ovmf-binary ${pkgs.OVMF-secureBoot.fd}/FV/OVMF_CODE.fd \
      --ovmf-template-vars ./OVMF_VARS.fd \
      --uefi-shell-iso ${UefiShell} \
      $out
  '';

  common = {
    virtualisation.useBootLoader = true;
    virtualisation.useEFIBoot = true;
    boot.loader.systemd-boot.enable = true;
  };
in
{
  basic = makeTest {
    name = "systemd-boot";
    meta.maintainers = with pkgs.stdenv.lib.maintainers; [ danielfullmer ];

    machine = { pkgs, lib, ... }: {
      imports = [ common ];
    };

    testScript = ''
      machine.wait_for_unit("multi-user.target")

      machine.succeed("test -e /boot/loader/entries/nixos-generation-1.conf")

      # Ensure we actually booted using systemd-boot
      machine.succeed(
          "test -e /sys/firmware/efi/efivars/LoaderEntrySelected-4a67b082-0a4c-41cf-b6c7-440b29bb8c4f"
      )
    '';
  };

  secureBoot = makeTest {
    name = "systemd-boot-secure";
    meta.maintainers = with pkgs.stdenv.lib.maintainers; [ danielfullmer ];

    machine = { pkgs, lib, ... }: {
      imports = [ common ];
      boot.loader.systemd-boot = {
        signed = true;
        signing-key = PkKek-snakeoil-key;
        signing-certificate = PkKek-snakeoil-crt;
      };
      virtualisation.defaultOVMFVars = ovmf-vars-enroll PkKek-snakeoil-crt;
      boot.loader.efi.canTouchEfiVariables = true;
    };

    testScript = ''
      machine.wait_for_unit("multi-user.target")

      machine.succeed("dmesg | grep -i 'Secure boot enabled'")
    '';
  };

  # Ensure we fail to boot if we didn't sign our bootloader
  secureBootFail = makeTest {
    name = "systemd-boot-secure-fail";
    meta.maintainers = with pkgs.stdenv.lib.maintainers; [ danielfullmer ];

    machine = { pkgs, lib, ... }: {
      imports = [ common ];
      virtualisation.defaultOVMFVars = ovmf-vars-enroll PkKek-snakeoil-crt;
      boot.loader.efi.canTouchEfiVariables = true;
    };

    testScript = ''
      # Tries to boot "Linux Boot Manager" EFI entry, but fails with "Security Violation" in the serial console.
      # not sure how to grep for that here...
      machine.start()
      machine.sleep(20)
    '';
  };
}
