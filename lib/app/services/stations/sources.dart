import 'package:radio/app/model/station_model.dart';
import 'package:radio/app/services/stations/sample_data.dart';

Future<List<Station>> getStationsFromLocalJson() async {
  List<Station> stations = stationsFromJson(localStations);
  Future.delayed(const Duration(milliseconds: 100), () {
    return stations;
  });
  return stations;
}
