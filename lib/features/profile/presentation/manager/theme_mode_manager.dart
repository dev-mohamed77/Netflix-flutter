// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/service/local_service/providers.dart';
import '../../../../core/service/local_service/shared_keys.dart';

class ThemeModeManager extends StateNotifier<bool?> {
  ThemeModeManager({
    required this.ref,
  }) : super(null) {
    getThemeState();
  }

  final Ref ref;

  Future<bool> _addLocalData(String key, dynamic value) async {
    final shared = await ref.watch(sharedServiceProvider);

    return shared.setData(key: key, value: value);
  }

  Object? _getLocalData(String key) async {
    final shared = await ref.watch(sharedServiceProvider);

    return shared.getData(key);
  }

  Future<bool> _addThemeData(bool value) {
    return _addLocalData(SharedPrefKeys.themeMode, value);
  }

  Future<bool?> _getThemeData() async {
    return await _getLocalData(SharedPrefKeys.themeMode) as bool?;
  }

  void getThemeState() async {
    final isTheme = await _getThemeData() ?? false;

    state = isTheme;
  }

  void selectThemeState(bool value) async {
    if (value == true) {
      await _addThemeData(true);
      state = true;
    } else {
      await _addThemeData(false);
      state = false;
    }
  }
}

final themeModeManagerProvider =
    StateNotifierProvider<ThemeModeManager, bool?>((ref) {
  return ThemeModeManager(ref: ref);
});
