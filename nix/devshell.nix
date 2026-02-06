{pkgs}: let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    buildToolsVersions = ["35.0.0"];
    platformVersions = ["36" "35" "34"];
    includeNDK = true;
    ndkVersions = ["28.2.13676358" "27.0.12077973"];
    includeCmake = true;
    cmakeVersions = ["3.22.1"];
    includeEmulator = false;
  };
  androidSdk = androidComposition.androidsdk;

  sdkPath = "${androidSdk}/libexec/android-sdk";
  cmakeToolchain = pkgs.writeText "nix-toolchain.cmake" ''
    set(OPENSSL_SSL_LIBRARY "${pkgs.openssl.out}/lib/libssl.so" CACHE FILEPATH "OpenSSL SSL library" FORCE)
    set(CMAKE_PREFIX_PATH "${pkgs.openssl.out};${pkgs.openssl.dev};''${CMAKE_PREFIX_PATH}" CACHE STRING "CMake prefix path" FORCE)
    set(OPENSSL_CRYPTO_LIBRARY "${pkgs.openssl.out}/lib/libcrypto.so" CACHE FILEPATH "OpenSSL crypto library" FORCE)
  '';
in
  pkgs.mkShell {
    ANDROID_SDK_ROOT = sdkPath;
    ANDROID_HOME = sdkPath;

    nativeBuildInputs = with pkgs; [
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
      export GRADLE_OPTS="-Dorg.gradle.project.android.aapt2FromMavenOverride=${sdkPath}/build-tools/35.0.0/aapt2"
    '';
  }
