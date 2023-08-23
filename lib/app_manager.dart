import 'dart:async';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:netflix/core/service/local_auth_service/local_auth_service.dart';
import 'package:netflix/core/service/local_service/shared_keys.dart';
import 'package:netflix/features/download/data/model/movie_download_model.dart';
import 'package:netflix/features/profile/presentation/manager/security_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';
import 'core/providers/token_local_provider.dart';
import 'features/auth/data/data_source/auth_local_data_source.dart';

class AppManager {
  const AppManager._();

  static Future<void> init() async {
    runZonedGuarded<Future<void>>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        final container = ProviderContainer();

        final isBiometricID = await _isBiometric(container);

        if (isBiometricID) {
          final localAuth = await _localAuthService();

          if (localAuth) {
            _buildNativeSplash();

            await _init();

            await _getTokenData(container);

            _buildFimberTree();

            _buildSystemUIOptions();

            runApp(
              UncontrolledProviderScope(
                container: container,
                child: const MyApp(),
              ),
            );
          }
        } else {
          _buildNativeSplash();

          await _init();

          await _getTokenData(container);

          _buildFimberTree();

          _buildSystemUIOptions();

          runApp(
            UncontrolledProviderScope(
              container: container,
              child: const MyApp(),
            ),
          );
        }
      },
      (error, stack) {
        Fimber.e('Error in main thread appeared. 😥 ',
            ex: error, stacktrace: stack);
      },
    );
  }

  static void _buildNativeSplash() {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    FlutterNativeSplash.remove();
  }

  static void _buildFimberTree() {
    if (kDebugMode) {
      Fimber.plantTree(DebugTree());
    }
  }

  static Future<void> _getTokenData(ProviderContainer ref) async {
    final token = await ref.read(authLocalDataSourceProvider).getToken();

    if (token != null) {
      ref.read(tokenLocalProvider.notifier).setToken(token.toString());
    } else {
      ref.read(tokenLocalProvider.notifier).setNull();
    }
  }

  static Future<void> _init() async {
    final document = await getApplicationDocumentsDirectory();
    await Hive.initFlutter();
    Hive.init(document.path);
    Hive.registerAdapter(MovieDownloadModelAdapter());
    Hive.openBox<MovieDownloadModel>(SharedPrefKeys.downloadMovieKey);

    // await AppEnvConfig.loadEnv();
  }

  static Future<bool> _localAuthService() {
    return LocalAuth.authenticate(
      title: 'To continue, you must complete the biometrics',
      useErrorDialogs: true,
    );
  }

  static Future<bool> _isBiometric(ProviderContainer ref) async {
    return await ref
            .read(securityManagerProvider.notifier)
            .getBiometricData() ??
        false;
  }

  static void _buildSystemUIOptions() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[80],
    ));

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }
}
