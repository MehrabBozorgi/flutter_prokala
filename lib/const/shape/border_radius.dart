import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BorderRadius getBorderRadiusFunc(double doubleRadius) {
  return BorderRadius.circular(ScreenUtil().setWidth(doubleRadius));
}

BorderRadius getButtonBorderRadiusWidget(double doubleRadius) {
  return BorderRadius.only(
    bottomLeft: Radius.circular(ScreenUtil().setWidth(doubleRadius)),
    bottomRight: Radius.circular(ScreenUtil().setWidth(doubleRadius)),
  );
}

BorderRadius getTopBorderRadiusWidget(double doubleRadius) {
  return BorderRadius.only(
    topLeft: Radius.circular(ScreenUtil().setWidth(doubleRadius)),
    topRight: Radius.circular(ScreenUtil().setWidth(doubleRadius)),
  );
}

BorderRadius getRightBorderRadiusWidget(double doubleRadius) {
  return BorderRadius.only(
    bottomRight: Radius.circular(ScreenUtil().setWidth(doubleRadius)),
    topRight: Radius.circular(ScreenUtil().setWidth(doubleRadius)),
  );
}

BorderRadius getLeftBorderRadiusWidget(double doubleRadius) {
  return BorderRadius.only(
    topLeft: Radius.circular(ScreenUtil().setWidth(doubleRadius)),
    bottomLeft: Radius.circular(ScreenUtil().setWidth(doubleRadius)),
  );
}

BorderRadius getTopRightBorderRadiusWidget(double doubleRadius) {
  return BorderRadius.only(
      topRight: Radius.circular(ScreenUtil().setWidth(doubleRadius)));
}

BorderRadius getTopLeftBorderRadiusWidget(double doubleRadius) {
  return BorderRadius.only(
      topLeft: Radius.circular(ScreenUtil().setWidth(doubleRadius)));
}

BorderRadius getBottomRightBorderRadiusWidget(double doubleRadius) {
  return BorderRadius.only(
      bottomRight: Radius.circular(ScreenUtil().setWidth(doubleRadius)));
}

BorderRadius getBottomLeftBorderRadiusWidget(double doubleRadius) {
  return BorderRadius.only(
      bottomLeft: Radius.circular(ScreenUtil().setWidth(doubleRadius)));
}