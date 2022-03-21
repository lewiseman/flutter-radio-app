import 'package:flutter/material.dart';
import 'package:radio/app/components/widgets/home.dart';
import 'package:radio/app/model/station_model.dart';
import 'package:radio/app/services/stations/sources.dart';
import 'package:radio_player/radio_player.dart';

class RadioHome extends StatefulWidget {
  const RadioHome({Key? key}) : super(key: key);

  @override
  State<RadioHome> createState() => _RadioHomeState();
}

class _RadioHomeState extends State<RadioHome> {
  RadioPlayer radioPlayer = RadioPlayer();
  List<Station> stations = [];
  Widget floatingBtn = const SizedBox();

  @override
  void initState() {
    super.initState();
    loadStations();
    // playerConnect();
  }

  void playerConnect() {
    radioPlayer.setChannel(
      title: 'title',
      url: '	http://91.121.165.88:8116/stream',
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const AppTitle(),
        bottom: PreferredSize(
          child: RadioSearch(size: size),
          preferredSize: const Size.fromHeight(58),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            homePartHeader('Recent'),
            FrequentStations(size: size, onTap: (st) {}, stations: stations),
            const SizedBox(height: 16),
            homePartHeader('Stations Available'),
            const SizedBox(height: 16),
            RadioStationsList(
              size: size,
              stations: stations,
              onTap: (st) {},
              playTapped: (st) => playStation(st),
            ),
          ],
        ),
      ),
      floatingActionButton: floatingBtn,
    );
  }

  loadStations() async {
    stations = await getStationsFromLocalJson();
    setState(() {});
  }

  playStation(Station st) {
    radioPlayer.setChannel(title: st.name, url: st.url).then((value) {
      radioPlayer.play().then((value) {
        setState(() {
          floatingBtn = FloatingActionButton(
            onPressed: () => radioPlayer.pause(),
            child: const Icon(Icons.pause),
          );
        });
      });
    });
  }
}
