import 'package:flutter/material.dart';

double getWidth(BuildContext context, double number) {
  return MediaQuery.of(context).size.width * number;
}

double getHeight(BuildContext context, double number) {
  return MediaQuery.of(context).size.height * number;
}

double getAllWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getAllHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
