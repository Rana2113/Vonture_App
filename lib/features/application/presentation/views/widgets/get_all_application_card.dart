import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';

class GetAllApplicationCard extends StatelessWidget {
  const GetAllApplicationCard(
      {super.key,
      required this.name,
      required this.nationality,
      required this.bio,
      required this.ontap});
  final String name;
  final String nationality;
  final String bio;
  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          verticalSpacing(20),
          Card(
            color: Colors.white,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: const BorderSide(color: PrimaryColor, width: 0.5),
            ),
            child: Container(
              height: 130,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/avatar.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: Styles.text18w400.copyWith(
                                decoration: TextDecoration.none,
                                color: PrimaryColor)),
                        Row(
                          children: [
                            Text(
                              'From: $nationality',
                              style: Styles.text14w600.copyWith(
                                height: 1.2,
                                color: textblue,
                              ),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Center(
                              child: SizedBox(
                                width: 115.w,
                                height: 35.h,
                                child: ElevatedButton(
                                  onPressed: ontap,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: white,
                                      side: const BorderSide(
                                        color: PrimaryColor,
                                        width: 1,
                                      )),
                                  child: Text(
                                    'view profile',
                                    style: Styles.text14w500.copyWith(
                                        color: PrimaryColor, height: 1),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          bio,
                          style: Styles.text16w500.copyWith(
                              height: 1.4,
                              overflow: TextOverflow.ellipsis,
                              decoration: TextDecoration.none,
                              color: PrimaryColor),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
