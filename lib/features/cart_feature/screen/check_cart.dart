import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prokala/features/authentication_features/screen/auth_screen.dart';

import '../../public_features/logic/token_check/token_check_cubit.dart';
import 'cart_screen.dart';

class CheckCart extends StatelessWidget {
  const CheckCart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenCheckCubit, TokenCheckState>(
      builder: (context, state) {
        if (state is TokenCheckIsLog) {
          return const CartScreen();
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}
