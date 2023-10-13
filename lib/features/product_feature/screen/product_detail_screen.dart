import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prokala/const/theme/colors.dart';
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

                  SizedBox(height: 2.5.sp),

                  /// comment section
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
