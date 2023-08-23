import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/service/local_service/shared_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefProvider = Provider((_) async {
  return await SharedPreferences.getInstance();
});

final sharedServiceProvider = Provider((ref) async {
  final shared = await ref.watch(sharedPrefProvider);
  return SharedService(sharedPreferences: shared);
});
