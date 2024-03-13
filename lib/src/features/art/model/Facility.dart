class Facility {
  final int code;
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
      code: json['code'],
      name: json['name'],
      partnerName: json['PartnerName'],
      facilityType: json['facility_type'],
      county: json['county'],
      telephone: json['telephone'],
    );
  }
}