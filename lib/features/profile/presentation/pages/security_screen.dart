import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/features/profile/presentation/manager/security_manager.dart';

class SecurityScreen extends ConsumerWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Security"),
      ),
      body: Column(
        children: [
          SwitchListTile.adaptive(
            secondary: const Icon(Icons.fingerprint_outlined),
            title: const Text(
              "BiometricID & FaceID",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            value: ref.watch(securityManagerProvider) ?? false,
            onChanged: (val) {
              ref
                  .read(securityManagerProvider.notifier)
                  .selectBiometricState(val);
            },
          ),
        ],
      ),
    );
  }
}
