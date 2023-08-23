import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/enum/gender.dart';

class GenderManager extends StateNotifier<Gender?> {
  GenderManager() : super(null);

  setGender(Gender? val) {
    state = val;
  }
}

final genderProvider = StateNotifierProvider<GenderManager, Gender?>((ref) {
  return GenderManager();
});
