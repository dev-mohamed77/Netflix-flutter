import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/features/movie/data/data_source/movie_local_data_source.dart';

class DownloadManager extends StateNotifier<bool?> {
  DownloadManager(this.ref) : super(null) {
    getState();
  }

  final Ref ref;

  Future<bool> _addDownloadWifiOnlyData(bool value) async {
    return await ref
        .watch(movieLocalDataSourceProvider)
        .addDownloadWifiOnly(isCheckDownloadWifiOnly: value);
  }

  Future<bool?> _getDownloadWifiOnlyData() async {
    return await ref.watch(movieLocalDataSourceProvider).getDownloadWifiOnly()
        as bool?;
  }

  getState() async {
    final bool? isDownloadLocal = await _getDownloadWifiOnlyData();

    state = isDownloadLocal ?? true;
  }

  select(bool value) async {
    if (value == true) {
      await _addDownloadWifiOnlyData(true);
      state = true;
    } else {
      await _addDownloadWifiOnlyData(false);
      state = false;
    }
  }
}

final downloadManagerProvider =
    StateNotifierProvider<DownloadManager, bool?>((ref) {
  return DownloadManager(ref);
});
