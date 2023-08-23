import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogCustom {
  DialogCustom._();

  static Future<void> showToast({
    required String message,
    required Color color,
  }) async {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static Future<void> showDialogCustom(
    BuildContext ctx, {
    required Widget child,
    bool barrierDismissible = true,
  }) async {
    showDialog(
        barrierDismissible: barrierDismissible,
        context: ctx,
        builder: (ctx) {
          return child;
        });
  }

  static Future<void> showModelBottomSheetCustom(
    BuildContext ctx, {
    required Widget child,
  }) async {
    showModalBottomSheet(
      context: ctx,
      showDragHandle: true,
      builder: (ctx) => child,
    );
  }

  static Future<void> showSnackBar(
    BuildContext ctx, {
    required String message,
  }) async {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message)));
  }
}
