import 'opportunity.dart';

class ApplicationModel {
  Opportunity? opportunity;

  ApplicationModel({this.opportunity});

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
      opportunity: json['opportunity'] == null
          ? null
          : Opportunity.fromJson(json['opportunity'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'opportunity': opportunity?.toJson(),
      };
}
