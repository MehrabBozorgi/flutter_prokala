import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prokala/const/shape/border_radius.dart';
import 'package:flutter_prokala/const/theme/colors.dart';
import 'package:flutter_prokala/features/cart_feature/logic/cart_bloc.dart';
import 'package:flutter_prokala/features/cart_feature/services/cart_repository.dart';
import 'package:flutter_prokala/features/public_features/functions/number_to_three.dart';
import 'package:flutter_prokala/features/public_features/widget/error_screen_widget.dart';
import 'package:flutter_prokala/features/public_features/widget/search_bar_widget.dart';
import 'package:flutter_prokala/features/public_features/widget/snack_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/responsive.dart';
import '../../../const/shape/media_query.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(CartRepository())..add(CallShowCartEvent()),
      child: BlocConsumer<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState) {
            return const Center(child: CircularProgressIndicator(color: primaryColor));
          }
          if (state is ShowCartCompletedState) {
            return Column(
              children: [
                const SearchBarWidget(),
                state.cartModel.cart!.isEmpty
                    ? const Expanded(child: EmptyWidget())
                    : Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        state.cartModel.cartCount.toString(),
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
                                      BlocProvider.of<CartBloc>(context)
                                          .add(DeleteAllItemsCartEvent());
                                    },
                                    icon: const Icon(Icons.delete_forever, color: Colors.red),
                                    label: const Text(
                                      'حذف سبد خرید',
                                      style: TextStyle(fontFamily: 'bold'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.separated(
                                separatorBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                                  child: const Divider(),
                                ),
                                itemCount: state.cartModel.cart!.length,
                                itemBuilder: (context, index) {
                                  final helper = state.cartModel.cart![index];
                                  return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 7.5.sp),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.sp, horizontal: 7.5.sp),
                                    height: Responsive.isTablet(context) ? 260 : 180,
                                    width: getAllWidth(context),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: FadeInImage(
                                                  placeholder: const AssetImage(
                                                      'assets/images/logo.png'),
                                                  image: NetworkImage(helper.productImage!),
                                                  placeholderErrorBuilder:
                                                      (context, error, stackTrace) =>
                                                          Container(),
                                                ),
                                              ),
                                              SizedBox(width: 10.sp),
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 10.sp),
                                                    Text(
                                                      helper.productTitle!,
                                                      style: TextStyle(
                                                        fontFamily: 'bold',
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5.sp),
                                                    Text(
                                                      '${getPriceFormat(helper.productPrice!.toString())} تومان',
                                                      style: TextStyle(
                                                        fontFamily: 'bold',
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.sp),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: greyColor, width: 2),
                                                            borderRadius:
                                                                getBorderRadiusFunc(7.5),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              IconButton(
                                                                onPressed: () {
                                                                  ///increase

                                                                  BlocProvider.of<CartBloc>(
                                                                          context)
                                                                      .add(
                                                                    ChangeCartCountEvent(
                                                                      productId: helper
                                                                          .productId!
                                                                          .toString(),
                                                                      cartId: helper.cartId
                                                                          .toString(),
                                                                      count: (int.parse(helper
                                                                                  .count!) +
                                                                              1)
                                                                          .toString(),
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
                                                                        BlocProvider.of<
                                                                                    CartBloc>(
                                                                                context)
                                                                            .add(DeleteItemCartEvent(
                                                                                helper.cartId
                                                                                    .toString()));
                                                                      },
                                                                      icon: const Icon(
                                                                        Icons
                                                                            .delete_forever_outlined,
                                                                        color: Colors.red,
                                                                      ),
                                                                    )
                                                                  : IconButton(
                                                                      onPressed: () {
                                                                        ///decrease
                                                                        BlocProvider.of<
                                                                                    CartBloc>(
                                                                                context)
                                                                            .add(
                                                                          ChangeCartCountEvent(
                                                                            productId: helper
                                                                                .productId!
                                                                                .toString(),
                                                                            cartId: helper
                                                                                .cartId
                                                                                .toString(),
                                                                            count: (int.parse(
                                                                                        helper
                                                                                            .count!) -
                                                                                    1)
                                                                                .toString(),
                                                                          ),
                                                                        );
                                                                      },
                                                                      icon: const Icon(
                                                                          Icons.remove),
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
                                },
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: EdgeInsets.all(8.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('ادامه خرید',
                                          style: TextStyle(fontFamily: 'bold')),
                                    ),
                                    Text(
                                      '${getPriceFormat(state.cartModel.cartTotal.toString())} تومان',
                                      style: TextStyle(fontFamily: 'bold', fontSize: 16.sp),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            );
          }
          if (state is CartErrorState) {
            return ErrorScreenWidget(
              errorMsg: state.errorMessage.errorMsg!,
              function: () {
                BlocProvider.of<CartBloc>(context).add(CallShowCartEvent());
              },
            );
          }

          return const SizedBox.shrink();
        },
        listener: (context, state) {
          // if(state is ChangeCountCompletedState){
          //
          //   getSnackBarWidget(context, 'تعداد محصول ویرایش شد', Colors.green);
          // }
        },
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty_box.png',
            width: getWidth(context, 0.5),
          ),
          SizedBox(height: 10.sp),
          Text(
            'هیچ محصولی انتخاب نکرده اید',
            style: TextStyle(fontFamily: 'bold', fontSize: 18.sp),
          )
        ],
      ),
    );
  }
}
