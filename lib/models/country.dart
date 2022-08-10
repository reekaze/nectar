class Country {
  late String code;
  late String name;
  Country({required this.code, required this.name});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(code: json['code'], name: json['name']);
  }
}
