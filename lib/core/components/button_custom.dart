import 'package:flutter/material.dart';
import 'package:netflix/core/manager/color/colors_manager.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    super.key,
    required this.title,
    required this.onClick,
    double? blurButton,
    Color? backgroundColor,
  })  : _blurButton = blurButton ?? 2,
        _backgroundColor = backgroundColor ?? AppColorsManager.accentColor;

  final Widget title;
  final void Function()? onClick;
  final double _blurButton;
  final Color _backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColorsManager.red,
            blurRadius: _blurButton,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Material(
        color: AppColorsManager.transparent,
        child: InkWell(
          onTap: onClick,
          borderRadius: BorderRadius.circular(30),
          splashColor: AppColorsManager.red,
          highlightColor: AppColorsManager.red,
          hoverColor: AppColorsManager.red,
          child: Center(
            child: title,
          ),
        ),
      ),
    );
  }
}
