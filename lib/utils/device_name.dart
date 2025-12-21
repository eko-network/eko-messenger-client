import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String> getDeiviceName() async {
  final deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final info = await deviceInfo.androidInfo;
    return '${info.manufacturer} ${info.model}';
  }

  if (Platform.isIOS) {
    final info = await deviceInfo.iosInfo;
    //FIXME https://pub.dev/packages/device_info_plus
    return info.name;
  }

  if (Platform.isMacOS) {
    final info = await deviceInfo.macOsInfo;
    return info.computerName;
  }

  if (Platform.isWindows) {
    final info = await deviceInfo.windowsInfo;
    return info.computerName;
  }

  if (Platform.isLinux) {
    final info = await deviceInfo.linuxInfo;
    return info.prettyName;
  }

  return 'Unknown device';
}
