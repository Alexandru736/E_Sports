import 'package:e_sports/models/spot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';

import 'details_page.dart';
import 'filter_page.dart';

class HomePage extends StatefulWidget {
  List<Spot> listOfCities = [];

  HomePage(List<Spot> listOfCities,
      {Key key}) {
      this.listOfCities = listOfCities;
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Spot>> futureSpots;

  @override
  void initState() {
    super.initState();
    futureSpots = Spot.getSpots();
    if(widget.listOfCities.isEmpty)
      print('balbal');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('KiteSurfing App'),
          backgroundColor: Color(0xff4D5EBD),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                  child: Icon(Icons.filter_list),
                  onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FutureBuilder(
                          future: futureSpots,
                          builder: (context, snapshot) {
                            List<Spot> data = snapshot.data;
                            if (data != null) {
                              if (data.length > 0) {
                                return FilterPage(data);
                              }
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            // By default, show a loading spinner.
                            return CircularProgressIndicator();
                          },
                        );
                      }));
                    }
                  ),
            )
          ],
        ),
        body: () {
          if (widget.listOfCities.isEmpty) {
            print("List of cities is null");
            return FutureBuilder(
              future: futureSpots,
              builder: (context, snapshot) {
                List data = snapshot.data;
                if (data != null) {
                  if (data.length > 0) {
                    return ListView(
                      children: _getListTiles(snapshot.data),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            );
          }
          else if(widget.listOfCities.isNotEmpty){
            print('list of cities is not null');
            print(widget.listOfCities.length);
            return ListView(
              children: _getListTiles(widget.listOfCities),
            );
          }
        }());
  }

  List<Widget> _getListTiles(List<Spot> listOfCities) {
    List<Widget> list = [];
    for (var city in listOfCities) {
      Widget tile = Card(
        elevation: 5,
        child: ListTile(
          title: Text(city.cityName),
          subtitle: Text(city.country),
          trailing: StarButton(
            isStarred: false,
            valueChanged: (_isStarred) {},
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsPage(city: city)));
          },
        ),
      );
      list.add(tile);
    }

    return list;
  }
}
