import 'package:flutter/material.dart';
import 'package:netflix/core/extensions/color_extensions.dart';

class TextFieldOTP extends StatelessWidget {
  const TextFieldOTP({
    super.key,
    required this.first,
    required this.last,
    required this.controller,
  });

  final bool first;
  final bool last;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.shade100.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: context.accentColor,
          width: 1.8,
        ),
      ),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 25),
        onChanged: (value) {
          if (value.isNotEmpty && last == false) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
        obscureText: true,
        obscuringCharacter: "*",
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width / 7,
            maxHeight: MediaQuery.sizeOf(context).width / 7,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
