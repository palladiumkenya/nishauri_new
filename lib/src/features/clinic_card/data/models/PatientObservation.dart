class PatientObservation {
  final String label;
  final String? value;

  PatientObservation({required this.label, this.value});

  factory PatientObservation.fromJson(Map<String, dynamic> json) {
    return PatientObservation(
      label: json['label'],
      value: json['value'],
    );
  }
}