import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../public_features/functions/number_to_three.dart';
import '../screen/payment_webview.dart';

class CartPriceSection extends StatelessWidget {
  const CartPriceSection({super.key, required this.cartTotal});

  final String cartTotal;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, PaymentSWebViewScreen.screenId);
              },
              child: const Text('ادامه خرید', style: TextStyle(fontFamily: 'bold')),
            ),
            Text(
              '${getPriceFormat(cartTotal)} تومان',
              style: TextStyle(fontFamily: 'bold', fontSize: 16.sp),
            )
          ],
        ),
      ),
    );
  }
}
