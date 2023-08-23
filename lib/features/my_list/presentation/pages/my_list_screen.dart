import 'package:flutter/material.dart';
import 'package:netflix/core/components/appbar_custom_section.dart';
import 'package:netflix/core/components/vertical_spacer.dart';
import 'package:netflix/features/my_list/presentation/pages/widgets/my_list_grid_view.dart';

class MyListScreen extends StatelessWidget {
  const MyListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const VerticalSpacer(15),
        AppBarCustomSection(title: 'My List', onClick: () {}),
        const Expanded(child: MyListGridView()),
      ],
    );
  }
}
