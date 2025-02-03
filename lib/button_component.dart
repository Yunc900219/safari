import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safari_v1/ThemeColorHelper.dart';

class LongPressIconButtonComponent extends StatelessWidget {
  const LongPressIconButtonComponent({
    super.key,
    required this.icon,
    required this.holdFunction,
    double? size,
  }) : _size = size ?? 50;

  final Widget icon;
  final void Function() holdFunction;
  final double _size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: holdFunction,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[700]!.withOpacity(0.5),
        ),
        height: _size.h,
        width: _size.w,
        child: Center(
          child: Padding(padding: const EdgeInsets.all(8.0), child: icon),
        ),
      ),
    );
  }
}

class TapIconButtonComponent extends StatelessWidget {
  TapIconButtonComponent({
    super.key,
    required this.icon,
    required this.tapFunction,
    Color? backgroundColor,
    double? size,
  })  : _size = size ?? 50,
        _backgroundColor =
            backgroundColor ?? ThemeColorHelper().tapIconButtonBG;

  final Widget icon;
  final void Function() tapFunction;
  final Color _backgroundColor;
  final double _size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapFunction,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: _backgroundColor,
        ),
        height: _size.h,
        width: _size.w,
        child: Center(child: icon),
      ),
    );
  }
}
