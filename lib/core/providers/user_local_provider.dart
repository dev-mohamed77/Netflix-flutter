import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/features/auth/domain/entities/user_entity.dart';

class UserLocal extends StateNotifier<UserEntity?> {
  UserLocal() : super(null);

  setUser(UserEntity user) {
    state = user;
    print("state =========>>>>>>>>> $state");
  }
}

final userLocalProvider = StateNotifierProvider<UserLocal, UserEntity?>(
  (ref) => UserLocal(),
);
