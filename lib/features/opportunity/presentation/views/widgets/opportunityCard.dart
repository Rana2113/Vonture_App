import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';

class OpportunityCard extends StatelessWidget {
  const OpportunityCard({
    super.key,
    this.onTap,
    required this.image,
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    required this.rating,
    required this.country,
  });

  final Function()? onTap;
  final String image;
  final String title;
  final String description;
  final String from;
  final String to;
  final double rating;
  final String country;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: PrimaryColor, width: 0.4)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    height: 120.h,
                    width: 90.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )),
              horizontalSpacing(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(title,
                              overflow: TextOverflow.ellipsis,
                              style: Styles.text16w400
                                  .copyWith(color: PrimaryColor, height: 2)),
                        ),
                        RatingBarIndicator(
                          rating: rating,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: PrimaryColor,
                          ),
                          itemCount: 1,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                        horizontalSpacing(5),
                        Text(rating.toString(), style: Styles.text16w400),
                      ],
                    ),
                    verticalSpacing(5),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                        ),
                        horizontalSpacing(5),
                        Text(
                          country,
                          style: Styles.text14w400,
                        ),
                      ],
                    ),
                    verticalSpacing(7),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 16,
                        ),
                        horizontalSpacing(5),
                        Text(
                          '$from - $to',
                          style: Styles.text14w400,
                        ),
                      ],
                    ),
                    verticalSpacing(5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: onTap,
                        child: Text(
                          'learn more',
                          style:
                              Styles.text14w400.copyWith(color: PrimaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
