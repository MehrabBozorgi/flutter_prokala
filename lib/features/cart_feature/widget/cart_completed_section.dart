import 'package:flutter/material.dart';
import 'package:flutter_prokala/features/cart_feature/widget/price_section.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../public_features/widget/empty_widget.dart';
import '../../public_features/widget/search_bar_widget.dart';
import '../model/cart_model.dart';
import 'cart_item.dart';
import 'delete_all_section.dart';

class CartCompletedSection extends StatelessWidget {
  const CartCompletedSection({super.key, required this.cartModel});

  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchBarWidget(),
        cartModel.cart!.isEmpty
            ? const Expanded(child: EmptyWidget())
            : Expanded(
                child: Column(
                  children: [
                    DeleteAllSection(cartModel: cartModel),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          child: const Divider(),
                        ),
                        itemCount: cartModel.cart!.length,
                        itemBuilder: (context, index) {
                          final helper = cartModel.cart![index];
                          return CartItem(helper: helper);
                        },
                      ),
                    ),
                    CartPriceSection(cartTotal: cartModel.cartTotal.toString()),
                  ],
                ),
              ),
      ],
    );
  }
}
