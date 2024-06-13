import 'opportunity.dart';

class ApplicationModel {
  Opportunity? opportunity;
  String? status;

  ApplicationModel({this.opportunity, this.status});

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
      opportunity: json['opportunity'] == null
          ? null
          : Opportunity.fromJson(json['opportunity'] as Map<String, dynamic>),
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'opportunity': opportunity?.toJson(),
        'status': status,
      };
}
