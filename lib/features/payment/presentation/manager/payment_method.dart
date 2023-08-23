import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix/core/enum/payment.dart';

class PaymentMethod extends StateNotifier<Payment> {
  PaymentMethod() : super(Payment.PayPal);

  void select(Payment value) => state = value;
}

final paymentMethodProvider =
    StateNotifierProvider<PaymentMethod, Payment>((ref) => PaymentMethod());
