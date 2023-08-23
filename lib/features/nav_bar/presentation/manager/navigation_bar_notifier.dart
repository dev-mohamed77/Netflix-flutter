import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationBarNotifier extends StateNotifier<int> {
  NavigationBarNotifier() : super(0);

  set index(int value) => state = value;

  void select(int value) => index = value;
}

final navigationBarProvider = StateNotifierProvider<NavigationBarNotifier, int>(
    (ref) => NavigationBarNotifier());
