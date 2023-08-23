import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/service/local_service/providers.dart';
import 'package:netflix/core/service/local_service/shared_keys.dart';

class SecurityManager extends StateNotifier<bool?> {
  SecurityManager(this.ref) : super(null) {
    getBiometricState();
    // getFaceIDState();
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

  Future<bool> _addBiometricData(bool value) {
    return _addLocalData(SharedPrefKeys.biometricID, value);
  }

  Future<bool?> getBiometricData() async {
    return await _getLocalData(SharedPrefKeys.biometricID) as bool?;
  }

  void getBiometricState() async {
    final isBiometric = await getBiometricData() ?? false;

    state = isBiometric;
  }

  void selectBiometricState(bool value) async {
    if (value == true) {
      await _addBiometricData(true);
      state = true;
    } else {
      await _addBiometricData(false);
      state = false;
    }
  }

  // ----------------- face id -----------------

  // Future<bool> _addFaceIDData(bool value) {
  //   return _addLocalData(SharedPrefKeys.faceID, value);
  // }

  // Future<bool?> getFaceIDData() async {
  //   return _getLocalData(SharedPrefKeys.faceID) as bool? ?? false;
  // }

  // void getFaceIDState() async {
  //   final isFaceID = await getFaceIDData();

  //   state = isFaceID ?? false;
  // }

  // void selectFaceIDState(bool value) async {
  //   if (value == true) {
  //     await _addFaceIDData(true);
  //     state = true;
  //   } else {
  //     await _addFaceIDData(false);
  //     state = false;
  //   }
  // }
}

final securityManagerProvider =
    StateNotifierProvider<SecurityManager, bool?>((ref) {
  return SecurityManager(ref);
});
