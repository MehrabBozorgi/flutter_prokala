import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prokala/const/responsive.dart';
import 'package:flutter_prokala/const/shape/media_query.dart';
import 'package:flutter_prokala/const/theme/colors.dart';
import 'package:flutter_prokala/features/favorite_features/model/favorite_model.dart';
import 'package:flutter_prokala/features/favorite_features/services/favorite_repository.dart';
import 'package:flutter_prokala/features/public_features/functions/number_to_three.dart';
import 'package:flutter_prokala/features/public_features/widget/empty_widget.dart';
import 'package:flutter_prokala/features/public_features/widget/error_screen_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../product_feature/screen/product_detail_screen.dart';
import '../logic/favorite_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  static const String screenId = '/favorite_screen';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'علاقه مندی ها',
          style: TextStyle(
            color: theme.textTheme.bodyMedium!.color,
            fontFamily: 'bold',
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => FavoriteBloc(FavoriteRepository())..add(CallFavoriteList()),
        child: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteLoadingState) {
              return const Center(child: CircularProgressIndicator(color: primaryColor));
            }
            if (state is FavoriteErrorState) {
              return ErrorScreenWidget(
                errorMsg: state.errorMessage.errorMsg!,
                function: () {
                  BlocProvider.of<FavoriteBloc>(context).add(CallFavoriteList());
                },
              );
            }
            if (state is FavoriteCompletedListState) {
              return state.favoriteModel.favorites!.isEmpty
                  ? const EmptyWidget(title: 'محصولی به علاقه مندی ها اضافه نشده')
                  : FavoriteListWidget(favoriteModel: state.favoriteModel);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class FavoriteListWidget extends StatelessWidget {
  const FavoriteListWidget({
    super.key,
    required this.favoriteModel,
  });

  final FavoriteModel favoriteModel;

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      separatorBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(8.sp),
        child: const Divider(),
      ),
      itemCount: favoriteModel.favorites!.length,
      itemBuilder: (context, index) {
        final helper = favoriteModel.favorites![index];
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
                SizedBox(width: getWidth(context, 0.04)),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        helper.productTitle!,
                        style: TextStyle(fontSize: 16.sp, fontFamily: 'bold'),
                        maxLines: 1,
                      ),
                      Text(
                        '${getPriceFormat(helper.productPrice!)} تومان',
                        style: TextStyle(fontSize: 15.sp, fontFamily: 'bold'),
                        maxLines: 1,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: OutlinedButton(
                          onPressed: () {
                            BlocProvider.of<FavoriteBloc>(context)
                                .add(RemoveFavoriteEvent(helper.id!));
                          },
                          child: const Text(
                            'حذف علاقه مندی',
                            style: TextStyle(fontFamily: 'bold'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
