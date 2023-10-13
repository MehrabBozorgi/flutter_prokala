
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/responsive.dart';
import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../cart_feature/logic/cart_bloc.dart';
import '../../cart_feature/services/cart_repository.dart';
import '../../public_features/functions/number_to_three.dart';
import '../../public_features/logic/token_check/token_check_cubit.dart';
import '../../public_features/widget/snack_bar.dart';
import '../model/product_model.dart';

class PriceSection extends StatelessWidget {
  const PriceSection({super.key, required this.helper, required this.productId});

  final ProductModel helper;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(5.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocProvider(
              create: (context) => CartBloc(CartRepository()),
              child: BlocConsumer<CartBloc, CartState>(
                listener: (context, state) {
                  if (state is CartErrorState) {
                    getSnackBarWidget(context, state.errorMessage.errorMsg!, Colors.red);
                  }
                  if (state is CartCompletedState) {
                    getSnackBarWidget(context, 'با موفقیت به سید اضافه شد', Colors.green);
                    helper.checkCart = true;
                  }
                },
                builder: (context, state) {
                  if (state is CartLoadingState) {
                    return const Center(child: CircularProgressIndicator(color: primaryColor));
                  }

                  return BlocBuilder<TokenCheckCubit, TokenCheckState>(
                    builder: (context, state) {
                      if (state is TokenCheckIsLog) {
                        return helper.checkCart!
                            ? const ElevatedButton(
                          onPressed: null,
                          child: Text(
                            'به سبد خرید اضافه شده',
                            style: TextStyle(fontFamily: 'bold'),
                          ),
                        )
                            : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                              getWidth(context, 0.35),
                              Responsive.isTablet(context) ? 60 : 45,
                            ),
                          ),
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context)
                                .add(AddToCartEvent(productId));
                          },
                          child: const Text(
                            'افزودن به سبد خرید',
                            style: TextStyle(fontFamily: 'bold'),
                          ),
                        );
                      } else {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary2Color,
                          ),
                          onPressed: () {
                            getSnackBarWidget(
                                context, 'وارد حساب کاربری خود شوید', Colors.red);
                          },
                          child: const Text(
                            'ورود به حساب',
                            style: TextStyle(fontFamily: 'bold'),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
            helper.percent == '0' || helper.totalPrice == 0
                ? Text(
              '${getPriceFormat(helper.product!.defaultPrice)} تومان',
              style: TextStyle(
                fontFamily: 'bold',
                fontSize: 18.sp,
              ),
            )
                : Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Text(
                    '${helper.percent} %',
                    style: TextStyle(
                      fontFamily: 'bold',
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: getWidth(context, 0.02)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      getPriceFormat(helper.product!.defaultPrice),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontFamily: 'normal',
                        fontSize: 16.sp,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Text(
                      '${getPriceFormat(helper.totalPrice.toString())} تومان',
                      style: TextStyle(fontFamily: 'bold', fontSize: 18.sp),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}