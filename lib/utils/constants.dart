import 'dart:io';

import 'package:flutter/foundation.dart';

final defaultUrl = Uri.parse("http://127.0.0.1:3000/");

const double conversationAvatarRadius = 20.0;
const String primaryColorKey = "pmk";
const String grayMessageColorKey = "gmk";
const double wideScreen = 700;

// Multi-instance support: Change appInstanceId to run multiple clients
// Example: "default", "instance2", "test", etc.
final String appInstanceId = kDebugMode
    ? Platform.environment['APP_INST'] ?? 'eko_messenger_dev'
    : "eko_messenger";
