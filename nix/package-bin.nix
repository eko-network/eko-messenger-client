{
  pkgs,
  lib,
}:
pkgs.stdenv.mkDerivation {
  pname = "eko_messenger";
  version = "0.0.9+9";

  src = pkgs.fetchurl {
    url = "https://github.com/eko-network/eko-messenger-client/releases/download/0.0.9%2B9/linux-release.tar.xz";
    sha256 = "sha256-NoAB7VjG8nQOX+O0HM4oRdAglDQcsxan2TB/aiSo4MY=";
  };

  sourceRoot = ".";

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
    copyDesktopItems
    autoPatchelfHook
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/lib
    cp -r * $out/lib/

    # Create wrapper script
    makeWrapper $out/lib/eko_messenger $out/bin/eko_messenger

    # Install icon
    mkdir -p $out/share/icons/hicolor/scalable/apps
    if [ -f assets/icon.svg ]; then
      install -Dm644 assets/icon.svg \
        "$out/share/icons/hicolor/scalable/apps/eko-messenger.svg"
    fi

    runHook postInstall
  '';

  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "com.eko.eko_messenger";
      exec = "eko_messenger";
      icon = "eko-messenger";
      desktopName = "Eko Messenger";
      comment = "An E2EE messaging application";
      categories = ["Network" "InstantMessaging"];
    })
  ];

  meta = with lib; {
    description = "Eko Messenger - Secure messaging application";
    homepage = "https://github.com/erreeves/eko-messenger-client";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "eko_messenger";
  };
}
