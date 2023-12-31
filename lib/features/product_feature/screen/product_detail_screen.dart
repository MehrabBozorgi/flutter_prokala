import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prokala/const/shape/media_query.dart';
import 'package:flutter_prokala/const/shape/shape.dart';
import 'package:flutter_prokala/const/theme/colors.dart';
import 'package:flutter_prokala/features/comment_features/screen/show_comment_screen.dart';
import 'package:flutter_prokala/features/product_feature/logic/product_bloc.dart';
import 'package:flutter_prokala/features/product_feature/model/product_model.dart';
import 'package:flutter_prokala/features/product_feature/services/product_repository.dart';
import 'package:flutter_prokala/features/public_features/widget/error_screen_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/price_section.dart';
import '../widget/product_app_bar.dart';
import '../widget/product_image_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  static const screenId = '/product_detail_screen';

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocProvider(
          create: (context) => ProductBloc(ProductRepository())
            ..add(CallProductEvent(arguments['product_id'].toString())),
          child: BlocConsumer<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoadingSate) {
                return const Center(child: CircularProgressIndicator(color: primaryColor));
              }
              if (state is ProductCompletedSate) {
                final helper = state.productModel;
                final carousel = BlocProvider.of<ProductBloc>(context).newGallery;
                return BodySection(
                  productId: arguments['product_id'].toString(),
                  helper: helper,
                  carousel: carousel,
                );
              }
              if (state is ProductErrorSate) {
                return ErrorScreenWidget(
                  errorMsg: state.errorMessage.errorMsg!,
                  function: () {
                    BlocProvider.of<ProductBloc>(context)
                        .add(CallProductEvent(arguments['product_id'].toString()));
                  },
                );
              }

              return const SizedBox.shrink();
            },
            listener: (context, state) {},
          ),
        ),
      ),
    );
  }
}

class BodySection extends StatelessWidget {
  const BodySection(
      {super.key, required this.productId, required this.helper, required this.carousel});

  final String productId;
  final ProductModel helper;
  final List<String> carousel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductAppBarWidget(productId: productId, helper: helper),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.sp,
              vertical: 10.sp,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///gallery

                  ProductImageWidget(helper: helper, carousel: carousel),

                  SizedBox(height: 20.sp),
                  Text(
                    helper.product!.title!,
                    style: TextStyle(fontFamily: 'bold', fontSize: 18.sp),
                  ),
                  SizedBox(height: 2.5.sp),
                  Text(
                    helper.product!.enName!,
                    style: TextStyle(fontFamily: 'bold', fontSize: 16.sp),
                  ),
                  SizedBox(height: 5.sp),
                  const Divider(),
                  SizedBox(height: 2.5.sp),
                  ExpandableText(
                    helper.product!.productBody!,
                    expandText: 'بیشتر',
                    collapseText: 'بستن',
                    maxLines: 4,
                    style: TextStyle(fontFamily: 'normal', fontSize: 14.sp),
                    linkColor: primaryColor,
                  ),

                  SizedBox(height: 15.sp),

                  /// comment section

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ShowCommentScreen.screenId,
                        arguments: {
                          'product_id': productId,
                        },
                      );
                    },
                    child: Column(
                      children: [
                        helper.userComments!.isEmpty
                            ? const SizedBox.shrink()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'دیدگاه های شما',
                                    style: TextStyle(fontFamily: 'bold', fontSize: 18.sp),
                                  ),
                                  Text(
                                    'تعداد دیدگاه ${helper.userComments!.length}',
                                    style: TextStyle(
                                      fontFamily: 'bold',
                                      fontSize: 16.sp,
                                      color: primary2Color,
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(height: 10.sp),

                        ///listViewvuilder

                        helper.userComments!.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: getAllWidth(context),
                                height: 180.sp,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: helper.userComments!.length,
                                  itemBuilder: (context, index) {
                                    final helperComment = helper.userComments![index];
                                    return Container(
                                      width: getWidth(context, 0.55),
                                      height: 160.sp,
                                      child: Card(
                                        shape: getShapeFunc(10),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12.5.sp, horizontal: 8.sp),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                helperComment.fullName!,
                                                style: TextStyle(
                                                    fontFamily: 'bold', fontSize: 16.sp),
                                              ),
                                              SizedBox(height: 2.5.sp),
                                              Expanded(
                                                child: Text(
                                                  helperComment.comment!,
                                                  style: const TextStyle(fontFamily: 'normal'),
                                                ),
                                              ),
                                              Divider(),
                                              Text(
                                                helperComment.date!,
                                                style: TextStyle(
                                                  fontFamily: 'bold',
                                                  fontSize: 16.sp,
                                                  color: primary2Color,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                        SizedBox(height: 15.sp),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'نظرات خود را نسبت به این محصول یادداشت کنید',
                              style: TextStyle(fontFamily: 'normal', fontSize: 16.sp),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15.sp),

                ],
              ),
            ),
          ),
        ),
        PriceSection(helper: helper, productId: productId),
      ],
    );
  }
}
