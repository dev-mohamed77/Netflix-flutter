import 'package:flutter/material.dart';

class AuthOrSection extends StatelessWidget {
  const AuthOrSection({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.grey[400],
              thickness: 0.5,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey[400],
              thickness: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
