import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileDataProvider = Provider(
  (ref) => [
    {
      "title": "Edit Profile",
      "icon": Icons.person_3_outlined,
    },
    {
      "title": "Change Password",
      "icon": Icons.change_circle_outlined,
    },
    {
      "title": "Download",
      "icon": Icons.downloading_outlined,
    },
    {
      "title": "Security",
      "icon": Icons.security_outlined,
    },
    {
      "title": "Dark Mode",
      "icon": Icons.remove_red_eye_outlined,
    },
    {
      "title": "Help Center",
      "icon": Icons.help_center_outlined,
    },
  ],
);
