class EssentailService{
  String name;

  EssentailService({required this.name});

  get getName => name;

  factory EssentailService.fromJson(Map<String, dynamic> json) {
    return EssentailService(
        name: json["name"]
    );
  }
}