import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:netflix/core/enum/payment.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';
import 'package:netflix/features/payment/presentation/manager/payment_method.dart';

class PaymentCard extends ConsumerWidget {
  const PaymentCard(
      {super.key,
      required this.title,
      required this.image,
      required this.radioValue});

  final String title;
  final String image;
  final Payment radioValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payment = ref.watch(paymentMethodProvider);
    return Card(
      child: RadioListTile<Payment>.adaptive(
        title: Row(
          children: [
            SvgPicture.asset(
              image,
              width: 35,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        groupValue: payment,
        onChanged: (Payment? value) {
          ref.read(paymentMethodProvider.notifier).select(value!);
        },
        value: radioValue,
        activeColor: AppColorsManager.accentColor,
      ),
    );
  }
}
