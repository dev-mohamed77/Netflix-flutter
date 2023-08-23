import 'package:flutter/widgets.dart';

class GlobalNavigatorKey {
  const GlobalNavigatorKey._();

  static final GlobalKey<NavigatorState> rootNavigator =
      GlobalKey(debugLabel: "root");

  static final GlobalKey<NavigatorState> shellNavigator =
      GlobalKey(debugLabel: "shell");
}
