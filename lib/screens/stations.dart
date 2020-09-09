import 'package:flutter/material.dart';

import '../models/radio_station.dart';
import '../utils/config.dart';
import '../widgets/radio_card.dart';

class StationsScreen extends StatelessWidget {
  final List<RadioStation> stations;
  final Function selectStation;

  StationsScreen({this.stations, this.selectStation});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        //height: 100,
        decoration: Config.backgroundGradient(),
        child: GridView.count(
          childAspectRatio: 5.0,
          crossAxisCount: 1,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          padding: EdgeInsets.all(2.0),
          children: this.stations.map((station) {
            int index = this.stations.indexOf(station);
            return RadioCard(
              station,
              index,
              this.selectStation,
            );
          }).toList(),
        ),
      ),
    );
  }
}
