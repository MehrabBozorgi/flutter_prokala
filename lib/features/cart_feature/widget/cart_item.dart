import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/responsive.dart';
import '../../../const/shape/border_radius.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/functions/number_to_three.dart';
import '../logic/cart_bloc.dart';
import '../model/cart_model.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.helper});

  final Cart helper;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7.5.sp),
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 7.5.sp),
      height: Responsive.isTablet(context) ? 320 : 260,
      width: getAllWidth(context),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/images/logo.png'),
                    image: NetworkImage(helper.productImage!),
                    placeholderErrorBuilder: (context, error, stackTrace) => Container(),
                  ),
                ),
                SizedBox(width: 10.sp),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.sp),
                      Text(
                        helper.productTitle!,
                        maxLines: 2,
                        style: TextStyle(fontFamily: 'bold', fontSize: 15.sp),
                      ),
                      SizedBox(height: 5.sp),
                      Text(
                        '${getPriceFormat(helper.productPrice!.toString())} تومان',
                        style: TextStyle(fontFamily: 'bold', fontSize: 15.sp),
                      ),
                      SizedBox(height: 10.sp),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: greyColor, width: 2),
                              borderRadius: getBorderRadiusFunc(7.5),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    ///increase

                                    BlocProvider.of<CartBloc>(context).add(
                                      ChangeCartCountEvent(
                                        productId: helper.productId!.toString(),
                                        cartId: helper.cartId.toString(),
                                        count: (int.parse(helper.count!) + 1).toString(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                                Text(
                                  helper.count.toString(),
                                  style: TextStyle(
                                    fontFamily: 'bold',
                                    fontSize: 18.sp,
                                  ),
                                ),
                                helper.count == '1'
                                    ? IconButton(
                                        onPressed: () {
                                          ///remove
                                          BlocProvider.of<CartBloc>(context)
                                              .add(DeleteItemCartEvent(helper.cartId.toString()));
                                        },
                                        icon: const Icon(
                                          Icons.delete_forever_outlined,
                                          color: Colors.red,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          ///decrease
                                          BlocProvider.of<CartBloc>(context).add(
                                            ChangeCartCountEvent(
                                              productId: helper.productId!.toString(),
                                              cartId: helper.cartId.toString(),
                                              count: (int.parse(helper.count!) - 1).toString(),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'هزینه ارسال',
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'bold',
                  fontSize: 16.sp,
                ),
              ),
              helper.productDeliveryPrice == 0
                  ? Text(
                      'رایگان',
                      style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'bold',
                        fontSize: 16.sp,
                      ),
                    )
                  : Text(
                      '${getPriceFormat(helper.productDeliveryPrice.toString())} تومان',
                      style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'bold',
                        fontSize: 16.sp,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
