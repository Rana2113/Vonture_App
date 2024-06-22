import 'package:flutter/material.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });
  final String title;
  final String subTitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Container(
        width: 48,
        height: 48,
        decoration: ShapeDecoration(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: PrimaryColor),
        child: Icon(
          icon,
          color: white,
        ),
      ),
      title: Text(title,
          style: Styles.text16w500
              .copyWith(decoration: TextDecoration.none, height: 1.2)),
      subtitle: Text(subTitle, style: Styles.text14w400.copyWith(height: 1.5)),
    );
  }
}
