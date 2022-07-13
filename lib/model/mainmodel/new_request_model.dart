class NewRequest {
  String user = '';
  List<String> disasterList = [];
  String disaster = '';
  List<String> essentialServiceList = [];
  String essentialService = '';
  String request = '';
  bool isEmergency = true;

  void setUser(String user) => this.user = user;
  void setDisasterList(List<String> disasterList) => this.disasterList = disasterList;
  void setDisaster(String disaster) => this.disaster = disaster;
  void setEssentialServiceList(List<String> essentialServiceList) => this.essentialServiceList = essentialServiceList;
  void setEssentialService(String essentialService) => this.essentialService = essentialService;
  void setRequest(String request) => this.request = request;
  void setIsEmergency(bool isEmergency) => this.isEmergency = isEmergency;

  get getUser => user;
  get getDisasterList => disasterList;
  get getDisaster => disaster;
  get getEssentialServiceList => essentialServiceList;
  get getEssentialService => essentialService;
  get getRequest => request;
  get getIsEmergency => isEmergency;
}