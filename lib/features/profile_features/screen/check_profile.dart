import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prokala/features/authentication_features/screen/auth_screen.dart';
import 'package:flutter_prokala/features/profile_features/screen/profile_screen.dart';
import 'package:flutter_prokala/features/public_features/logic/token_check/token_check_cubit.dart';

class CheckProfile extends StatelessWidget {
  const CheckProfile({super.key});

  static const String screenId = '/check_profile';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenCheckCubit, TokenCheckState>(
      builder: (context, state) {
        if (state is TokenCheckIsLog) {
          return const ProfileScreen();
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}
