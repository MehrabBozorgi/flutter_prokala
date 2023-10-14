import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

RoundedRectangleBorder getShapeFunc(double doubleRadius) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(ScreenUtil().setWidth(doubleRadius)),
  );
}
