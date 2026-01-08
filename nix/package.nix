{
  pkgs,
  lib,
}:
let
  # Create a CMake toolchain file for OpenSSL
  cmakeToolchain = pkgs.writeText "flutter-toolchain.cmake" ''
    set(OPENSSL_ROOT_DIR "${pkgs.openssl.dev}" CACHE PATH "OpenSSL root directory" FORCE)
    set(OPENSSL_INCLUDE_DIR "${pkgs.openssl.dev}/include" CACHE PATH "OpenSSL include directory" FORCE)
    set(OPENSSL_CRYPTO_LIBRARY "${pkgs.openssl.out}/lib/libcrypto.so" CACHE FILEPATH "OpenSSL crypto library" FORCE)
    set(OPENSSL_SSL_LIBRARY "${pkgs.openssl.out}/lib/libssl.so" CACHE FILEPATH "OpenSSL SSL library" FORCE)
  '';
in
pkgs.flutter.buildFlutterApplication {
  pname = "eko-messenger";
  version = "0.1.0";

  src = lib.cleanSource ../.;

  # Use autoPubspecLock for automatic dependency resolution
  autoPubspecLock = ../pubspec.lock;

  gitHashes = {
    ecp = "sha256-yejYOwWJ2OUfqQx+h81pacOESC2hEKDOn+w7D14pR2I=";
  };

  buildInputs = with pkgs; [
    gtk3
    glib
    jsoncpp
    openssl
    libsecret
  ];

  nativeBuildInputs = with pkgs; [
    pkg-config
    wrapGAppsHook3
  ];

  # Override the build to use CMake toolchain
  buildPhase = ''
    runHook preBuild
    
    export CMAKE_TOOLCHAIN_FILE="${cmakeToolchain}"
    
    mkdir -p build/flutter_assets/fonts
    flutter build linux -v --split-debug-info="$debug" $flutterBuildFlags

    runHook postBuild
  '';

  meta = with lib; {
    description = "Eko Messenger - Secure messaging application";
    homepage = "https://github.com/erreeves/eko-messenger-client";
    license = licenses.unfree;
    platforms = platforms.linux;
    mainProgram = "eko_messanger";
  };
}
