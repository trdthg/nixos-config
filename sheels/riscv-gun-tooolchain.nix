let pkgs = import <nixpkgs> { };
in
with pkgs.stdenv;
with pkgs.stdenv.lib;
pkgs.mkShell {
  name = "riscv-shell";
  nativeBuildInputs = with pkgs.buildPackages; [ bash gnumake cmake curl git utillinux ];
  buildInputs = with pkgs; [
    stdenv
    binutils
    cmake
    pkgconfig
    curl
    autoconf
    automake
    python3
    libmpc
    mpfr
    gmp
    gawk
    bison
    flex
    texinfo
    gperf
    libtool
    patchutils
    bc
    libdeflate
    expat
    gnumake
    pkgs.gnumake

    utillinux
    bash
  ];

  hardeningDisable = [ "all" ];
}

