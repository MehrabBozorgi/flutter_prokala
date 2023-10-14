import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prokala/const/theme/colors.dart';
import 'package:flutter_prokala/features/cart_feature/logic/cart_bloc.dart';
import 'package:flutter_prokala/features/cart_feature/services/cart_repository.dart';
import 'package:flutter_prokala/features/public_features/widget/error_screen_widget.dart';
import '../widget/cart_completed_section.dart';

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
            return CartCompletedSection(cartModel: state.cartModel);
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
