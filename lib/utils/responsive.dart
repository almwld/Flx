import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Responsive {
  static void init(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812), minTextAdapt: true);
  }

  static double sp(double size) => size.sp;
  static double w(double width) => width.w;
  static double h(double height) => height.h;
}
