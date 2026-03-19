import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Responsive {
  static void init(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812), minTextAdapt: true);
  }

  // أحجام الخطوط النسبية
  static double sp(double size) => size.sp;
  // أبعاد نسبية
  static double w(double width) => width.w;
  static double h(double height) => height.h;
  // حجم الخط بناءً على نوع الجهاز
  static double fontSize(double size) {
    if (ScreenUtil().screenWidth > 600) {
      return size * 1.2; // للأجهزة اللوحية
    }
    return size;
  }

  // التحقق من حجم الشاشة
  static bool isTablet() => ScreenUtil().screenWidth >= 600;
  static bool isPhone() => ScreenUtil().screenWidth < 600;
}
