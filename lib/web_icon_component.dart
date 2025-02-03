import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class WebIconComponent extends StatelessWidget {
  WebIconComponent({
    super.key,
    required this.icon,
    Color? backgroundColor,
    required this.text,
  }) : _backgroundColor = backgroundColor ?? Colors.transparent;

  Widget icon;
  Color _backgroundColor;
  String text;

  @override
  Widget build(BuildContext context) {
    return
    // Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 13.41.w, vertical: 10.h),
    //   child:
    Column(
      children: [
        Container(
          height: 70.h,
          width: 70.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _backgroundColor,
          ),
          child: Center(child: icon),
        ),
        SizedBox(height: 8.h),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'CustomFont',
            fontSize: 12.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
      // ),
    );
    ;
  }
}
