import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Row(
        children: [
          const Spacer(
            flex: 1,
          ),
          Center(
              child: SizedBox(
                  height: 50.h,
                  width: 120.w,
                  child: Image.asset('assets/LOGO2.png'))),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
