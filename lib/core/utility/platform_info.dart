import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;

import '../enum/platform.dart';

class PlatFormInfo {
  static bool isDesktopOs() =>
      Platform.isLinux || Platform.isMacOS || Platform.isWindows;

  static bool isMobileOs() => Platform.isAndroid || Platform.isIOS;

  static bool isWeb() => kIsWeb;

  PlatformType getCurrentPlatformType() {
    if (kIsWeb) {
      return PlatformType.Web;
    }
    if (Platform.isMacOS) {
      return PlatformType.MacOs;
    }
    if (Platform.isFuchsia) {
      return PlatformType.Fuchsia;
    }
    if (Platform.isLinux) {
      return PlatformType.Linux;
    }
    if (Platform.isWindows) {
      return PlatformType.Windows;
    }
    if (Platform.isIOS) {
      return PlatformType.Ios;
    }
    if (Platform.isAndroid) {
      return PlatformType.Android;
    }
    return PlatformType.Unknown;
  }
}
