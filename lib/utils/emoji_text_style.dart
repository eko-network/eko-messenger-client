import 'dart:io';

import 'package:flutter/material.dart';

TextStyle emojiTextStyle(TextStyle style) {
  if (Platform.isLinux) {
    return style.copyWith(fontFamilyFallback: ["NotoEmoji"]);
  }
  return style;
}
