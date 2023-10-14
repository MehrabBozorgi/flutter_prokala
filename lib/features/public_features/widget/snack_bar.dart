import 'package:flutter/material.dart';

import '../../../const/shape/shape.dart';

getSnackBarWidget(BuildContext context, String text, Color color) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      shape: getShapeFunc(10),
      behavior: SnackBarBehavior.floating,
      content: Text(text,style: TextStyle(fontFamily: 'bold'),),
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(milliseconds: 2000),
    ),
  );
}
