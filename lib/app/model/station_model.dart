import 'dart:convert';

List<Station> stationsFromJson(String data) => List<Station>.from(jsonDecode(data).map((x) => Station.fromJson(x)));

class Station {
  String stationuuid;
  String name;
  String favicon;
  String url;
  String country;
  List<String> language;

  Station({
    required this.name,
    required this.url,
    required this.favicon,
    required this.country,
    required this.language,
    required this.stationuuid,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    
    return Station(
      stationuuid: json['stationuuid'],
      name: json['name'],
      favicon: json['favicon'],
      url: json['url'],
      country: json['country'],
      language:List<String>.from(json['language']),
    );
  }
}
