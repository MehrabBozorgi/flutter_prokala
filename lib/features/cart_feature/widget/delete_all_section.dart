import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../logic/cart_bloc.dart';
import '../model/cart_model.dart';

class DeleteAllSection extends StatelessWidget {
  const DeleteAllSection({
    super.key,
    required this.cartModel,
  });

  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                cartModel.cart!.length.toString(),
                style: TextStyle(
                  fontFamily: 'bold',
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(width: 5.sp),
              const Text(
                'محصول در سبد خرید',
                style: TextStyle(fontFamily: 'bold'),
              ),
            ],
          ),
          TextButton.icon(
            onPressed: () {
              BlocProvider.of<CartBloc>(context).add(DeleteAllItemsCartEvent());
            },
            icon: const Icon(Icons.delete_forever, color: Colors.red),
            label: const Text(
              'حذف سبد خرید',
              style: TextStyle(fontFamily: 'bold'),
            ),
          ),
        ],
      ),
    );
  }
}
