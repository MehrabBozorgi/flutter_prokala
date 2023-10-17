import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prokala/const/shape/border_radius.dart';
import 'package:flutter_prokala/const/shape/media_query.dart';
import 'package:flutter_prokala/features/category_features/logic/category_bloc.dart';
import 'package:flutter_prokala/features/category_features/model/category_model.dart';
import 'package:flutter_prokala/features/category_features/screen/all_category_screen.dart';
import 'package:flutter_prokala/features/category_features/services/category_repository.dart';
import 'package:flutter_prokala/features/home_features/widget/sliver_search_bar.dart';
import 'package:flutter_prokala/features/public_features/widget/error_screen_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const String screenId = '/category_screen';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => CategoryBloc(CategoryRepository())..add(CallCategory()),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoadingState) {
            return const CategoryLoading();
          }
          if (state is CategoryCompletedState) {
            CategoryModel categoryModel = state.categoryModel;
            return CustomScrollView(
              slivers: [
                SliverSearchBar(theme: theme),
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      SizedBox(
                        width: getAllWidth(context),
                        height: getAllHeight(context) -
                            kBottomNavigationBarHeight *
                                MediaQuery.of(context).devicePixelRatio,
                        child: ListView.builder(
                          itemCount: categoryModel.category!.length,
                          itemBuilder: (context, catIndex) {
                            final categoryHelper = categoryModel.category![catIndex];
                            return CategoryItems(categoryHelper: categoryHelper);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          if (state is CategoryErrorState) {
            return ErrorScreenWidget(
              errorMsg: state.error.errorMsg!,
              function: () {
                BlocProvider.of<CategoryBloc>(context).add(CallCategory());
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class CategoryItems extends StatelessWidget {
  const CategoryItems({
    super.key,
    required this.categoryHelper,
  });

  final Category categoryHelper;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.sp),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
          child: Text(
            categoryHelper.title!,
            style: TextStyle(fontFamily: 'bold', fontSize: 18.sp),
          ),
        ),
        SizedBox(
          width: getAllWidth(context),
          height: getWidth(context, 0.45),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: categoryHelper.subCategory!.length,
            itemBuilder: (context, subCatIndex) {
              final subCategoryHelper = categoryHelper.subCategory![subCatIndex];
              return SubCategoryItems(subCategoryHelper: subCategoryHelper);
            },
          ),
        )
      ],
    );
  }
}

class SubCategoryItems extends StatelessWidget {
  const SubCategoryItems({
    super.key,
    required this.subCategoryHelper,
  });

  final SubCategory subCategoryHelper;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(subCategoryHelper.id);
        Navigator.pushNamed(context, AllCategoryScreen.screenId, arguments: {
          'category_id': subCategoryHelper.id.toString(),
        });
      },
      child: Container(
        width: getWidth(context, 0.3),
        height: getWidth(context, 0.375),
        margin: EdgeInsets.all(5.sp),
        padding: EdgeInsets.all(5.sp),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: getBorderRadiusFunc(10.sp),
        ),
        child: Column(
          children: [
            subCategoryHelper.image == null
                ? Image.asset(
                    'assets/images/logo.png',
                    width: getWidth(context, 0.25),
                    height: getWidth(context, 0.325),
                  )
                : ClipRRect(
                    borderRadius: getBorderRadiusFunc(10),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/images/logo.png'),
                      image: NetworkImage(subCategoryHelper.image!),
                      width: getWidth(context, 0.25),
                      height: getWidth(context, 0.325),
                      imageErrorBuilder: (context, error, stackTrace) => SizedBox(
                        width: getWidth(context, 0.25),
                        height: getWidth(context, 0.325),
                      ),
                    ),
                  ),
            Text(
              subCategoryHelper.title!,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'bold',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryLoading extends StatelessWidget {
  const CategoryLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Wrap(
          runSpacing: 15.sp,
          children: const [
            ShimmerContainer(),
            ShimmerContainer(),
            ShimmerContainer(),
            ShimmerContainer(),
            ShimmerContainer(),
            ShimmerContainer(),
            ShimmerContainer(),
            ShimmerContainer(),
            ShimmerContainer(),
            ShimmerContainer(),
            ShimmerContainer(),
            ShimmerContainer(),
          ],
        ),
      ),
    );
  }
}

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.sp),
      width: getWidth(context, 0.28),
      height: getWidth(context, 0.4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: getBorderRadiusFunc(10),
      ),
    );
  }
}
