import 'package:flutter/material.dart';
import 'package:netflix/features/profile/presentation/pages/widgets/edit_profile_body.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fill Your Profile",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const EditProfileBody(),
    );
  }
}
