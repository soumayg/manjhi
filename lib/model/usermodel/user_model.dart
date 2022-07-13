class User{
  String mobileNumber = '';
  String name = '';

  int baby = 0;
  int child = 0;
  int adult = 0;
  int senior = 0;
  int ph = 0;

  String address = '';
  String area = '';
  String district = '';
  String state = '';
  String country = '';

  void setMobileNumber(String mobileNumber) => this.mobileNumber = mobileNumber;
  void setName(String name) => this.name = name;

  void setBaby(int baby) => this.baby = baby;
  void setChild(int child) => this.child = child;
  void setAdult(int adult) => this.adult = adult;
  void setSenior(int senior) => this.senior = senior;
  void setPh(int ph) => this.ph = ph;

  void setAddress(String address) => this.address = address;
  void setArea(String area) => this.area = area;
  void setDistrict(String district) => this.district = district;
  void setState(String state) => this.state = state;
  void setCountry(String country) => this.country = country;

  get getMobileNumber => mobileNumber;
  get getName => name;

  get getBaby => baby;
  get getChild => child;
  get getAdult => adult;
  get getSenior => senior;
  get getPh => ph;

  get getAddress => address;
  get getArea => area;
  get getDistrict => district;
  get getState => state;
  get getCountry => country;
}