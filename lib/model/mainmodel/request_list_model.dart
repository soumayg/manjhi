class HelpRequest {
  String disaster;
  String service;
  String request;
  bool isEmergency;
  bool isInProgress;
  bool isComplete;

  get getDisaster => disaster;
  get getService => service;
  get getRequest => request;
  get getIsEmergency => isEmergency;
  get getIsInProgress => isInProgress;
  get getIsComplete => isComplete;

  HelpRequest(this.disaster, this.service, this.request, this.isEmergency, this.isInProgress,
      this.isComplete);

  factory HelpRequest.fromJson(Map<String, dynamic> json) {
    return HelpRequest(
        json["disaster"] as String,
        json["eservice"] ?? '',
        json["request"] as String,
        json["is_emergency"] as bool,
        json["is_progress"] as bool,
        json["is_complete"] as bool);
  }
}
