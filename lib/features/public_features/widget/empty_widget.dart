import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/shape/media_query.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty_box.png',
            width: getWidth(context, 0.5),
          ),
          SizedBox(height: 10.sp),
          Text(
            'هیچ محصولی انتخاب نکرده اید',
            style: TextStyle(fontFamily: 'bold', fontSize: 18.sp),
          )
        ],
      ),
    );
  }
}
