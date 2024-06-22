import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';

class MyOpportunityCard extends StatelessWidget {
  const MyOpportunityCard({
    super.key,
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    required this.id,
    required this.status,
    this.onTap,
    required this.image,
  });

  final String title;
  final String description;
  final String from;
  final String to;
  final int id;
  final String status;
  final void Function()? onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: Colors.white,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    height: 200.h,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )),
              verticalSpacing(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  title,
                  style: Styles.text18w400
                      .copyWith(color: PrimaryColor, height: 0.5),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              verticalSpacing(8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Text(
                  description,
                  style: Styles.text16w400
                      .copyWith(height: 1.5, color: PrimaryColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              verticalSpacing(4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('$from To $to',
                    style: Styles.text16w400
                        .copyWith(color: PrimaryColor, height: 1.2)),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
