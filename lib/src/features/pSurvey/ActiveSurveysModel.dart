
class ActiveSurvey {
  final int id;
  final String surveyTitle;
  final String surveyDescription;
  // final String status;
  // final String createdAt;
  // final String activeTill;
  // final int createdBy;
  // final bool hasUploadedData;

  ActiveSurvey({
    required this.id,
    required this.surveyTitle,
    required this.surveyDescription,
    // required this.status,
    // required this.createdAt,
    // required this.activeTill,
    // required this.createdBy,
    // required this.hasUploadedData,
  });

  factory ActiveSurvey.fromJson(Map<String, dynamic> json) {
    return ActiveSurvey(
      id: json['id'] ?? 0,
      surveyTitle: json['name'] ?? 'No Title',
      surveyDescription: json['description'] ?? 'No Description',
      // status: json['is_active'] ?? 'No Status',
      // createdAt: json['created_at'] ?? '',
      // activeTill: json['active_till'] ?? '',
      // createdBy: json['created_by'] ?? 0,
      // hasUploadedData: json['has_uploaded_data'] ?? false,
    );
  }
}
