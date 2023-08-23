import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/components/button_custom.dart';
import 'package:netflix/core/components/vertical_spacer.dart';
import 'package:netflix/core/enum/payment.dart';
import 'package:netflix/core/manager/router/routes.dart';
import 'package:netflix/features/payment/presentation/pages/widgets/payment_card.dart';
import 'package:netflix/features/plans/domain/entity/plan_entity.dart';

import '../../../../core/config/app_assets_config.dart';
import '../../../../core/manager/color/colors_manager.dart';
import '../manager/payment_method.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.plan});

  final PlanEntity plan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Payment",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Spacer(
                flex: 1,
              ),
              const PaymentCard(
                title: "PayPal",
                image: AppAssetsConfig.paypal,
                radioValue: Payment.PayPal,
              ),
              const VerticalSpacer(15),
              const PaymentCard(
                title: "Visa",
                image: AppAssetsConfig.visa,
                radioValue: Payment.Visa,
              ),
              const Spacer(
                flex: 4,
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, _) {
                  final payment = ref.watch(paymentMethodProvider);
                  return ButtonCustom(
                    title: const Text(
                      "Continue",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColorsManager.white,
                      ),
                    ),
                    onClick: () {
                      if (payment == Payment.PayPal) {
                        context.pushNamed(Routes.paypal, extra: plan);
                      } else {
                        context.pushNamed(Routes.visa, extra: plan);
                      }
                    },
                  );
                },
              ),
              const VerticalSpacer(20),
            ],
          ),
        ));
  }
}
