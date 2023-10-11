import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_prokala/const/responsive.dart';
import 'package:flutter_prokala/const/shape/media_query.dart';
import 'package:flutter_prokala/const/theme/colors.dart';
import 'package:flutter_prokala/features/authentication/logic/auth_bloc.dart';
import 'package:flutter_prokala/features/authentication/screen/verify_screen.dart';
import 'package:flutter_prokala/features/authentication/services/auth_repository.dart';
import 'package:flutter_prokala/features/public_features/widget/snack_bar.dart';
import 'package:flutter_prokala/features/public_features/widget/text_form_fileds/text_form_field_mobile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  static const String screenId = '/authentication_screen';

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController _controller = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              height: getWidth(context, 0.5),
              color: primaryColor,
            ),
          ),
          BlocProvider(
            create: (context) => AuthBloc(AuthRepository()),
            child: BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }

                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(getWidth(context, 0.03)),
                    child: Form(
                      key: _globalKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            width: getWidth(context, 0.2),
                          ),
                          SizedBox(height: 25.sp),
                          Text(
                            'برای ورود به حساب کاربری / ثبت نام ایمیل خود را وارد کنید',
                            style: TextStyle(
                              fontFamily: 'normal',
                              fontSize: 14.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          TextFormFieldMobileWidget(
                            labelText: 'شماره موبایل',
                            icon: const Icon(Icons.phone_android_outlined),
                            textInputAction: TextInputAction.done,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            controller: _controller,
                          ),
                          SizedBox(height: 30.sp),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(getWidth(context, 0.65),
                                  Responsive.isTablet(context) ? 60 : 45),
                            ),
                            onPressed: () {
                              if (_globalKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();

                                ///event
                                BlocProvider.of<AuthBloc>(context)
                                    .add(CallAuthEvent(_controller.text));
                              }
                            },
                            child: const Text(
                              'دریافت کد امنیتی',
                              style: TextStyle(fontFamily: 'bold'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              listener: (context, state) {
                if (state is AuthCompletedState) {
                  // Map<String, dynamic> arguments = {
                  //   'value1': 'Hello',
                  //   'value2': 'Flutter',
                  // };
                  Navigator.of(context).pushNamed(
                    VerifyScreen.screenId,
                    arguments: {'code': state.code, 'phone_number': state.phoneNumber},
                  );
                  if (kDebugMode) {
                    print(state.code.toString());
                  }
                }
                if (state is AuthErrorState) {
                  getSnackBarWidget(
                    context,
                    state.errorMessageClass.errorMsg!,
                    Colors.red,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
