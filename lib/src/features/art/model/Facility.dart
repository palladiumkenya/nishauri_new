class Facility {
  final String code;
  final String name;
  final String partnerName;
  final String facilityType;
  final String county;
  final String telephone;

  Facility({
    required this.code,
    required this .name,
    required this.partnerName,
    required this.facilityType,
    required this.county,
    required this.telephone,
  });

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(
      code: json['code'] ?? "",
    //  code: json['code'].toString(), // Parse as a string
      name: json['name'] ?? "",
      partnerName: json['PartnerName'] ?? "",
      facilityType: json['facility_type'] ?? "",
      county: json['county'] ?? "",
      telephone: json['telephone'] ?? "",
    );
  }
}