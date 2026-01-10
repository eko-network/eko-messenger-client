import 'dart:io';

import 'package:flutter/foundation.dart';

final defaultUrl = kDebugMode
    ? Uri.parse("http://127.0.0.1:3000/")
    : Uri.parse("https://messages.eko-app.com/");

const double conversationAvatarRadius = 20.0;
const String primaryColorKey = "pmk";
const String grayMessageColorKey = "gmk";
const double wideScreen = 700;

final isMobile = Platform.isAndroid || Platform.isIOS;
final isDesktop = !isMobile;
// Multi-instance support: Change appInstanceId to run multiple clients
final String appInstanceId = kDebugMode
    ? Platform.environment['APP_INST'] ?? 'eko_messenger_dev'
    : "eko_messenger";
