{
  description = "Flutter";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config = {
          android_sdk.accept_license = true;
          allowUnfree = true;
        };
      };
      androidComposition = pkgs.androidenv.composeAndroidPackages {
        buildToolsVersions = ["35.0.0"];
        platformVersions = [36 35 34 33 31];
        includeNDK = true;
        ndkVersions = ["27.0.12077973"];
        includeCmake = true;
        cmakeVersions = ["3.22.1"];
        includeEmulator = false;
        includeSystemImages = true;
        systemImageTypes = ["google_apis"];
      };
      androidSdk = androidComposition.androidsdk;

      cmakeToolchain = pkgs.writeText "nix-toolchain.cmake" ''
        set(OPENSSL_SSL_LIBRARY "${pkgs.openssl.out}/lib/libssl.so" CACHE FILEPATH "OpenSSL SSL library" FORCE)
        set(CMAKE_PREFIX_PATH "${pkgs.openssl.out};${pkgs.openssl.dev};''${CMAKE_PREFIX_PATH}" CACHE STRING "CMake prefix path" FORCE)
        set(OPENSSL_CRYPTO_LIBRARY "${pkgs.openssl.out}/lib/libcrypto.so" CACHE FILEPATH "OpenSSL crypto library" FORCE)
      '';
    in {
      devShell = with pkgs;
        mkShell rec {
          ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
          ANDROID_HOME = "${androidSdk}/libexec/android-sdk";

          nativeBuildInputs = [
            dart
            flutter
            androidSdk
            jdk
            ninja
            pkg-config
            libsecret.dev
            jsoncpp.dev
            unzip
            cmake
            clang
            gtk3
            openssl.dev
            openssl.out
          ];

          shellHook = ''
            export CMAKE_TOOLCHAIN_FILE="${cmakeToolchain}"
          '';
        };
    });
}
