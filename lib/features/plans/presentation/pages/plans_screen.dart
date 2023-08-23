import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/manager/router/routes.dart';
import 'package:netflix/core/providers/token_local_provider.dart';
import 'package:netflix/core/service/local_service/providers.dart';
import 'package:netflix/core/service/local_service/shared_keys.dart';
import 'package:netflix/features/plans/presentation/pages/widgets/plans_body.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (BuildContext context, WidgetRef ref, _) {
            return TextButton(
              child: const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                final sharedService = await ref.read(sharedServiceProvider);
                sharedService
                    .deleteData(key: SharedPrefKeys.signInKey)
                    .then((value) {
                  if (value) {
                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                    ref.read(tokenLocalProvider.notifier).state = null;
                    context.go(Routes.welcome);
                  }
                });
              },
            );
          },
        ),
      ),
      body: const PlansBody(),
    );
  }
}
