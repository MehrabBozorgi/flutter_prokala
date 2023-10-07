import 'package:intl/intl.dart';

final formatPattern = NumberFormat('###,###,###');

String getPriceFormat(price) {
  return formatPattern.format(double.parse(price));
}
