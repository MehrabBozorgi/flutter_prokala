import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../const/shape/media_query.dart';
import '../../../const/theme/colors.dart';
import '../../public_features/logic/bottom_nav_cubit.dart';
import '../../public_features/screens/bottom_nav_bar.dart';
import '../../public_features/widget/snack_bar.dart';

class PaymentSWebViewScreen extends StatefulWidget {
  const PaymentSWebViewScreen({Key? key}) : super(key: key);
  static const String screenId = '/payment_webview_screen';

  @override
  State<PaymentSWebViewScreen> createState() => _PaymentSWebViewScreenState();
}

class _PaymentSWebViewScreenState extends State<PaymentSWebViewScreen> {
  WebViewController _controller = WebViewController();

  webView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url == 'app://open_flutter_prokala/succeed') {
            //   // Handle the deep link.
            //   // ...
            //   getSnackBarWidget(context, 'سفارش شما با موفقیت ثبت شد', Colors.green);
            //   BlocProvider.of<BottomNavCubit>(context).onTap(0);
            //   Navigator.pushNamedAndRemoveUntil(context, BottomNavBarScreen.screenId, (route) => false);
            //   return NavigationDecision.navigate;
            // } else if (request.url == 'app://open_flutter_prokala/failed') {
            //   getSnackBarWidget(context, 'سفارش شما با شکست مواجه شد، دوباره تلاش کنید', Colors.red);
            //   navIndex = 0;
            //   Navigator.pushNamedAndRemoveUntil(context, BottomNavBarScreen.screenId, (route) => false);
            //   return NavigationDecision.navigate;
            // }

            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://mehrabbozorgi.ir'));
  }

  @override
  void initState() {
    webView();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool canScope = false;

    var pressCount = 0;
    return SafeArea(
      child: Scaffold(
        body: PopScope(
          canPop: canScope,
          onPopInvoked: (value) async {
            final canGoBack = await _controller.canGoBack() ?? false;
            if (canGoBack) {
              _controller.goBack();

              canScope = false;
            } else {
              pressCount++;

              if (pressCount == 2) {
                BlocProvider.of<BottomNavCubit>(context).onTap(0);
                Navigator.of(context).pushNamedAndRemoveUntil(BottomNavBarScreen.screenId, (route) => false);
                canScope = false;
              } else {
                Future.delayed(const Duration(milliseconds: 1500)).whenComplete(() => pressCount--);
                getSnackBarWidget(context, 'برای بازگشت به صفحه اصلی یکبار دیگر کلیک کنید', Colors.black);
                canScope = false;
              }
            }
          },
          child: WebViewWidget(controller: _controller),
        ),
      ),
    );
  }
}
