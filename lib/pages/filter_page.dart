import 'package:e_sports/models/cities.dart';
import 'package:e_sports/models/spot.dart';
import 'package:e_sports/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';


class FilterPage extends StatefulWidget {

  List<Spot> listOfCities;

  FilterPage(List<Spot> listOfCities, {Key key}) {
    this.listOfCities = listOfCities;
  }

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  List<Spot> filteredCities;
  TextEditingController _country = new TextEditingController();
  TextEditingController _windProbability = new TextEditingController();
  TextEditingController _whenToGo = new TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCities = widget.listOfCities;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        backgroundColor: Color(0xff4D5EBD),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 80,),
              myTextForm('Enter country', 'Country', Icons.location_city,
                  _country),
              SizedBox(height: 25,),
              myTextForm('Enter wind probability', 'Wind probability',
                  Icons.accessibility, _windProbability),
              SizedBox(height: 25,),
              myTextForm('Enter month', 'Month',
                  Icons.date_range_rounded, _whenToGo),
              SizedBox(height: 50,),
              applyButton()
            ],
          )
        ),
      ),
    );
  }

  Widget applyButton() {
    return InkWell(
      onTap : () async {
        List<Spot> list = filter();
        if(list.isNotEmpty)
          for(var i in list)
            print(i.country);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage(list)));
      },
      child: Container(
        width: 200,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffA6AFDE),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          'Apply',
          style: TextStyle(fontSize: 20, color: Color(0xff6876C7)),
        ),
      ),
    );
  }


  Widget myTextForm(String hintText, String labelText, IconData icon,
      TextEditingController controllerText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: controllerText,
        cursorColor: Color(0xff6876C7),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black38),
          labelText: labelText,
          labelStyle: TextStyle(color: Color(0xff6876C7)),
          hoverColor: Color(0xff6876C7),
          fillColor: Color(0xff6876C7),
          focusColor: Color(0xff6876C7),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xff6876C7)
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xff6876C7)
              )
          ),
          suffixIcon: Icon(
            icon, color: Color(0xff6876C7),
          ),
        ),
      ),
    );
  }

  List<Spot> filter() {
    List<Spot> listOfFiltered = [];
    for(var city in filteredCities) {
      bool ok = true;
      if(_windProbability.text != '' &&
          double.parse(_windProbability.text) != city.windProbability) {
        ok = false;
      }
      if(_country.text != city.country
          && _country.text != '') {
        ok = false;
      }
      if(_whenToGo.text != city.whenToGo
          && _whenToGo.text != '') {
        ok = false;
      }
      if(ok == true)
        listOfFiltered.add(city);
    }
    return listOfFiltered;
  }
}