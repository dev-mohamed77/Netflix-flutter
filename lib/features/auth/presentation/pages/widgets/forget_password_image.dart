import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ForgetPasswordImage extends StatelessWidget {
  const ForgetPasswordImage({super.key, required this.assetName});

  final String assetName;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: MediaQuery.sizeOf(context).height / 3.5,
    );
  }
}
