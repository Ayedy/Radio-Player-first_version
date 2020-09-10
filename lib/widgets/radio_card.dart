import 'package:flutter/material.dart';

import '../models/radio_station.dart';

class RadioCard extends StatelessWidget {
  final RadioStation station;
  final int index;
  final Function _selectStation;

  RadioCard(
    this.station,
    this.index,
    this._selectStation,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 500,
          //color: Colors.orange,
          child: Column(
            children: [
              OutlineButton(
                onPressed: () => this._selectStation(this.station.url),
                padding: EdgeInsets.all(0),
                borderSide: (this.station.selected)
                    ? BorderSide(color: Colors.blue, width: 2.0)
                    : BorderSide(color: Colors.black12),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    width: 500,
                    //color: Colors.red,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          this.station.name,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        (this.station.frequency != 0.0)
                            ? Text(
                                this.station.frequency.toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              )
                            : Text(''),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
