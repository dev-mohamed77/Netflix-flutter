import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/components/loading_page.dart';
import 'package:netflix/core/components/vertical_spacer.dart';
import 'package:netflix/core/manager/router/routes.dart';
import 'package:netflix/features/plans/presentation/manager/provider.dart';
import 'package:netflix/features/plans/presentation/pages/widgets/plan_item.dart';

class PlansBody extends StatelessWidget {
  const PlansBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VerticalSpacer(15),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "Choose the plan that suits you",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const VerticalSpacer(15),
        Expanded(
          child: Consumer(
            builder: (context, ref, child) {
              final plans = ref.watch(getPlansUseCaseProvider);

              return plans.when(
                loading: () => const LoadingPage(title: "Loading .."),
                data: (data) => PageView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return PlanItem(
                      plan: data![index],
                      onClick: () {
                        context.pushNamed(
                          Routes.payment,
                          extra: data[index],
                        );
                      },
                    );
                  },
                ),
                error: (error, stackTrace) =>
                    Center(child: Text(error.toString())),
                skipLoadingOnReload: true,
              );
            },
          ),
        ),
      ],
    );
  }
}
