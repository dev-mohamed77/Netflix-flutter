import 'package:flutter/material.dart';
import 'package:netflix/features/profile/presentation/pages/widgets/download_setting_body.dart';

class DownloadSettingScreen extends StatelessWidget {
  const DownloadSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Download",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const DownloadSettingBody(),
    );
  }
}
