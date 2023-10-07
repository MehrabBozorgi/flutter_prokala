import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

RoundedRectangleBorder getShapeWidget(double doubleRadius) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(ScreenUtil().setWidth(doubleRadius)),
  );
}
