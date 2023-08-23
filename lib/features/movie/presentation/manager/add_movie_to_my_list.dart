import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddMovieToMyList extends StateNotifier<bool?> {
  AddMovieToMyList() : super(null);

  getState(bool value) {
    state = value;
  }

  select(bool value) {
    state = !value;
  }
}
