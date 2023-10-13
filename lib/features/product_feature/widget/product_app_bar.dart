import 'package:flutter/material.dart';

import '../model/product_model.dart';
import 'favorite_button.dart';

class ProductAppBarWidget extends StatelessWidget {
  const ProductAppBarWidget({
    super.key,
    required this.productId,
    required this.helper,
  });

  final String productId;
  final ProductModel helper;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
            FavoriteButton(
              id: productId,
              status: helper.fav!,
            ),
          ],
        ),
      ],
    );
  }
}