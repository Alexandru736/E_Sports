import 'package:e_sports/models/spot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final Spot city;

  const DetailsPage({Key key, this.city}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEAECF7),
      appBar: AppBar(
        title: Text(widget.city.cityName),
        backgroundColor: Color(0xff4D5EBD),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: <Widget>[
            SizedBox(
              height: 40,
            ),
            _field('Country', widget.city.country),
            SizedBox(height: 10,),
            _field('Latitude', widget.city.latitude.toString()),
            SizedBox(height: 10,),
            _field('Longitude', widget.city.longitude.toString()),
            SizedBox(height: 10,),
            _field('Wind probability', widget.city.windProbability.toString()),
            SizedBox(height: 10,),
            _field('When to go', widget.city.whenToGo),
          ]),
        ),
      ),
    );
  }
}

Widget _field(String string, String profile_string) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
      child: Container(
          height: 60,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                string + ": " + profile_string,
                style: TextStyle(color: Colors.black38, fontSize: 18),
              ),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(width: 1.0, color: Colors.black38))));
}
