import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:radio/app/model/station_model.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      // ignore: prefer_const_constructors
      text: TextSpan(
        text: 'RA',
        style: const TextStyle(
          fontSize: 28,
          color: Colors.white,
        ),
        children: const [
          TextSpan(
            text: 'D',
            style: TextStyle(color: Colors.orange),
          ),
          TextSpan(
            text: 'IO',
            style: TextStyle(),
          ),
        ],
      ),
    );
  }
}

class RadioSearch extends StatelessWidget {
  const RadioSearch({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * .06,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextFormField(
          style: const TextStyle(
            fontSize: 18,
          ),
          decoration: const InputDecoration.collapsed(
              hintText: 'Search for a radio station here',
              hintStyle: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

Text homePartHeader(String title) {
  return Text(
    title,
    style: const TextStyle(fontSize: 28),
  );
}

class FrequentStations extends StatelessWidget {
  const FrequentStations({
    Key? key,
    required this.size,
    required this.stations,
    required this.onTap,
  }) : super(key: key);

  final Size size;
  final List<Station> stations;
  final ValueChanged<Station> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * .2,
      child: GridView.builder(
        padding: const EdgeInsets.only(top: 16),
        itemCount: stations.length <= 5 ? stations.length : 5,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
          maxCrossAxisExtent: size.height * .2,
        ),
        itemBuilder: (context, index) {
          Station station = stations[index];
          return InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () => onTap(station),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CachedNetworkImage(imageUrl: station.favicon),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    station.name,
                    maxLines: 2,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class RadioStationsList extends StatelessWidget {
  const RadioStationsList({
    Key? key,
    required this.size,
    required this.stations,
    required this.onTap,
    required this.playTapped,
  }) : super(key: key);

  final Size size;
  final List<Station> stations;
  final ValueChanged<Station> onTap;
  final ValueChanged<Station> playTapped;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stations.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        Station station = stations[index];
        return Container(
          height: size.height * .14,
          margin: const EdgeInsets.only(bottom: 14),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: size.width * .8,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: getInnerPadding(), top: 16, bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                station.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                station.country,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.orange),
                              ),
                              Text(
                                station.language.join(', '),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => playTapped(station),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          child: const Icon(
                            Icons.play_arrow_outlined,
                            color: Colors.white,
                            size: 45,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                child: Center(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: size.height * .12,
                    width: size.height * .12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.transparent,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: station.favicon,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double getInnerPadding() {
    var x = size.height * .12;
    var y = size.width * .8;
    var z = x + y;
    var a = size.width;
    return (z - a) * 5;
  }
}
