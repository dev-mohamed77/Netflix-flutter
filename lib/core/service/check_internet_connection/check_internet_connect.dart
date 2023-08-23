// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckInternetConnection {
  CheckInternetConnection({
    required this.connectivity,
  });

  final Connectivity connectivity;

  Future<ConnectivityResult> get isConnect async => await _checkConnectivity();

  Future<ConnectivityResult> _checkConnectivity() async =>
      await connectivity.checkConnectivity();
}

final checkInternetConnection = Provider(
  (ref) => CheckInternetConnection(
    connectivity: Connectivity(),
  ),
);
