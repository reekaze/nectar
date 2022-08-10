class City {
  late String id;
  late String name;
  late String country;

  City({required this.id, required this.name, required this.country});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        id: json["id"].toString(),
        name: json["name"],
        country: json["country"]);
  }
}
