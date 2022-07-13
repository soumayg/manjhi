class Disaster{
  String name;

  Disaster({required this.name});

  get getName => name;

  factory Disaster.fromJson(Map<String, dynamic> json) {
    return Disaster(
        name: json["name"]
    );
  }
}