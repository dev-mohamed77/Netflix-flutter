import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix/core/manager/router/routes.dart';
import 'package:netflix/features/plans/domain/entity/plan_entity.dart';
import 'package:netflix/features/plans/presentation/manager/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisaScreen extends ConsumerStatefulWidget {
  const VisaScreen({super.key, required this.plan});
  final PlanEntity plan;

  @override
  ConsumerState<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends ConsumerState<VisaScreen> {
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
          onProgress: (int progress) {
            print(progress);
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://accept.paymob.com/')) {
              _subPlanDemo();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          "https://880d-156-219-92-88.ngrok-free.app/paymob?amount=${widget.plan.price}00"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Visa Payment",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
