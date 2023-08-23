import 'package:flutter/material.dart';

extension ColorSchemaExtension on BuildContext {
  Color get accentColor => Theme.of(this).colorScheme.primary;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get backgroundColor => Theme.of(this).colorScheme.background;
  Color get scrimColor => Theme.of(this).colorScheme.scrim;
}
