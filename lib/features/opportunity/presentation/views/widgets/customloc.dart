import 'package:flutter/material.dart';

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
      leading: Container(
        width: 48,
        height: 48,
        decoration: ShapeDecoration(
          color: const Color(0xFFF4F2EF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Icon(
          icon,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF161111),
          fontSize: 16,
          fontFamily: 'Work Sans',
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: const TextStyle(
          color: Color(0xFF876B63),
          fontSize: 14,
          fontFamily: 'Work Sans',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
