import 'package:flutter/material.dart';
import 'package:vonture_grad/core/components/spacing.dart';
import 'package:vonture_grad/core/constants.dart/colors.dart';
import 'package:vonture_grad/core/constants.dart/styles.dart';

class OpportunityRequirements extends StatelessWidget {
  const OpportunityRequirements({super.key, required this.requirements});

  final List<String> requirements;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Requirements', style: Styles.text24w700.copyWith(fontSize: 26)),
        verticalSpacing(10),
        for (String requirement in requirements) ...[
          Row(
            children: [
              const Text('•  ', style: Styles.text24w700),
              Flexible(
                child: Text(requirement,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Styles.text16w500.copyWith(
                        color: PrimaryColor, decoration: TextDecoration.none)),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ],
    );
  }
}
