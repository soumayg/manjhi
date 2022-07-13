class EmergencyHelpLine{
  String organization;
  String contactNumber;

  EmergencyHelpLine({required this.organization, required this.contactNumber});

  get getOrganization => organization;
  get getContactNumber => contactNumber;

  factory EmergencyHelpLine.fromJson(Map<String, dynamic> json) {
    return EmergencyHelpLine(
      organization: json["organization"],
      contactNumber: json["contact_number"],
    );
  }
}