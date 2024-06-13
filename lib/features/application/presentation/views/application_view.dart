import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/features/application/presentation/views/application_card.dart';

class ApplicationView extends StatelessWidget {
  const ApplicationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ApplicationCard(
            title: 'Live in a castle',
            dateRange: '1-12-2023 - 31-1-2024',
            status: 'Status: Pending',
            imageUrl: 'assets/shelter.jpg',
          ),
          // child: Container(
          //   width: 388.w,
          //   height: 120.h,
          //   padding: const EdgeInsets.all(16),
          //   clipBehavior: Clip.antiAlias,
          //   decoration: ShapeDecoration(
          //     color: Colors.white,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     shadows: const [
          //       BoxShadow(
          //         color: Color(0x19000000),
          //         blurRadius: 4,
          //         offset: Offset(0, 0),
          //         spreadRadius: 0,
          //       )
          //     ],
          //   ),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Container(
          //         width: 190.w,
          //         height: 200.h,
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Container(
          //               width: double.infinity,
          //               height: 20.h,
          //               child: Column(
          //                 mainAxisSize: MainAxisSize.min,
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   SizedBox(
          //                     width: double.infinity,
          //                     child: Text(
          //                       'Live in a castle',
          //                       style: TextStyle(
          //                         color: Color(0xFF111416),
          //                         fontSize: 16.sp,
          //                         fontFamily: 'Plus Jakarta Sans',
          //                         fontWeight: FontWeight.w700,
          //                         height: 0.08,
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             const SizedBox(height: 4),
          //             Container(
          //               width: double.infinity,
          //               height: 21.h,
          //               child: Column(
          //                 mainAxisSize: MainAxisSize.min,
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   SizedBox(
          //                     width: double.infinity,
          //                     child: Text(
          //                       'Dec 1, 2023 - Jan 31, 2024',
          //                       style: TextStyle(
          //                         color: Color(0xFF607789),
          //                         fontSize: 14.sp,
          //                         fontFamily: 'Plus Jakarta Sans',
          //                         fontWeight: FontWeight.w400,
          //                         height: 0.11,
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       const SizedBox(width: 16),
          //       Container(
          //         width: 119.w,
          //         height: 58.h,
          //         clipBehavior: Clip.antiAlias,
          //         decoration: ShapeDecoration(
          //           image: const DecorationImage(
          //             image: AssetImage('assets/shelter.jpg'),
          //             fit: BoxFit.fill,
          //           ),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(12),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      surfaceTintColor: kLogoColor,
      title: SizedBox(
        height: 50.h,
        width: 120.w,
        child: Image.asset("assets/LOGO2.png"),
      ),
      centerTitle: true,
    );
  }
}
