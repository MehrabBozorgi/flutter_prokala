import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prokala/const/shape/media_query.dart';
import 'package:flutter_prokala/const/theme/colors.dart';
import 'package:flutter_prokala/features/category_features/logic/category_bloc.dart';
import 'package:flutter_prokala/features/category_features/model/all_category_model.dart';
import 'package:flutter_prokala/features/category_features/services/category_repository.dart';
import 'package:flutter_prokala/features/product_feature/screen/product_detail_screen.dart';
import 'package:flutter_prokala/features/public_features/functions/number_to_three.dart';
import 'package:flutter_prokala/features/public_features/widget/empty_widget.dart';
import 'package:flutter_prokala/features/public_features/widget/error_screen_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/responsive.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  static const String screenId = '/all_category_screen';

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: BlocProvider(
        create: (context) => CategoryBloc(CategoryRepository())
          ..add(CallAllCategoryEvent(arguments['category_id'])),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is AllCategoryLoadingState) {
              return const Center(child: CircularProgressIndicator(color: primaryColor));
            }
            if (state is AllCategoryCompletedState) {
              return RefreshIndicator(
                color: primaryColor,
                onRefresh: () async {
                  context
                      .read<CategoryBloc>()
                      .add(CallAllCategoryEvent(arguments['category_id']));
                },
                child: state.allCategoryModel.product == null
                    ? EmptyWidget(title: 'این دسته بندی محصولی ندارد')
                    : ListView.builder(
                        itemCount: state.allCategoryModel.product!.length,
                        itemBuilder: (context, index) {
                          final helper = state.allCategoryModel.product![index];
                          return AllCategoryItem(helper: helper);
                        },
                      ),
              );
            }
            if (state is AllCategoryErrorState) {
              return ErrorScreenWidget(
                errorMsg: state.error.errorMsg!,
                function: () {
                  context
                      .read<CategoryBloc>()
                      .add(CallAllCategoryEvent(arguments['category_id']));
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class AllCategoryItem extends StatelessWidget {
  const AllCategoryItem({super.key, required this.helper});

  final Product helper;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailScreen.screenId, arguments: {
          'product_id': helper.productId,
        });
      },
      child: Container(
        width: getAllWidth(context),
        height: Responsive.isTablet(context) ? 230 : 150,
        padding: EdgeInsets.symmetric(
          horizontal: getWidth(context, 0.04),
          vertical: getWidth(context, 0.02),
        ),
        child: Row(
          children: [
            Expanded(
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/logo.png'),
                image: NetworkImage(helper.productImage!),
                imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/images/logo.png',
                  width: getWidth(context, 0.3),
                ),
              ),
            ),
            SizedBox(width: getWidth(context, 0.03)),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    helper.productTitle!,
                    style: TextStyle(fontFamily: 'bold', fontSize: 16.sp),
                  ),
                  Text(
                    '${getPriceFormat(helper.productPrice!.toString())} تومان',
                    style: TextStyle(fontFamily: 'bold', fontSize: 16.sp),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
