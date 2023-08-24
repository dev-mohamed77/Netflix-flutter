import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/manager/router/routes.dart';
import '../../../plans/domain/entity/plan_entity.dart';
import '../../../plans/presentation/manager/provider.dart';

class PayPalScreen extends ConsumerStatefulWidget {
  const PayPalScreen({super.key, required this.plan});

  final PlanEntity plan;

  @override
  ConsumerState<PayPalScreen> createState() => _PayPalScreenState();
}

class _PayPalScreenState extends ConsumerState<PayPalScreen> {
  late WebViewController controller;

  _subPlanDemo() {
    ref
        .read(onSubscribeUseCaseProvider.notifier)
        .execute(planId: widget.plan.id)
        .then((value) {
      context.go(Routes.home);
    });
  }

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.sandbox.paypal.com/')) {
              _subPlanDemo();
              return NavigationDecision.navigate;
            }
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          "https://880d-156-219-92-88.ngrok-free.app/paypal?amount=${widget.plan.price}&currency=usd"));

    super.initState();
  }

// http://localhost:3000/paypal?amount=165&currency=usd
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Paypal Payment",
      )),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}


// http://192.168.1.6:3000/paypal?amount=165&currency=usd