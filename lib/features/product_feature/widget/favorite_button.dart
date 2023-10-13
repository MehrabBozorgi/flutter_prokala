import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/theme/colors.dart';
import '../../favorite_features/logic/favorite_bloc.dart';
import '../../favorite_features/services/favorite_repository.dart';
import '../../public_features/logic/token_check/token_check_cubit.dart';
import '../../public_features/widget/snack_bar.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.id, required this.status});

  final String id;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenCheckCubit, TokenCheckState>(
      builder: (context, state) {
        if (state is TokenCheckIsLog) {
          return FavoriteButtonWithToken(
            id: id,
            productStatus: status,
          );
        }
        return IconButton(
          onPressed: () {
            getSnackBarWidget(context, 'وارد حساب کاربری خود شوید', Colors.red);
          },
          icon: const Icon(Icons.favorite_border),
        );
      },
    );
  }
}

class FavoriteButtonWithToken extends StatelessWidget {
  FavoriteButtonWithToken({super.key, required this.id, required this.productStatus});

  final String id;
  bool productStatus;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc(FavoriteRepository()),
      child: BlocConsumer<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
          if (state is FavoriteErrorState) {
            getSnackBarWidget(context, state.errorMessage.errorMsg!, Colors.red);
          }
          if (state is FavoriteCompletedState) {
            if (state.status) {
              getSnackBarWidget(context, 'محصول به علاقه مندی ها اضافه شد', Colors.green);
              productStatus = true;
            } else {
              getSnackBarWidget(context, 'محصول از علاقه مندی ها حذف شد', Colors.green);
              productStatus = false;
            }
          }
        },
        builder: (context, state) {
          if (state is FavoriteLoadingState) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(5.sp),
                child: const CircularProgressIndicator(color: primaryColor),
              ),
            );
          }

          return IconButton(
            onPressed: () {
              BlocProvider.of<FavoriteBloc>(context).add(AddToFavoriteEvent(id));
            },
            icon: productStatus
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite_border),
          );
        },
      ),
    );
  }
}


