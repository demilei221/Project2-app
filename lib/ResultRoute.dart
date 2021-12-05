import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'History.dart';
import 'Location.dart';
import 'input.dart';

/// This is the stateful widget that the main application instantiates.
class ResultRoute extends StatefulWidget {
  const ResultRoute(
      {Key? key,
        required this.address,
        required this.county,
        required this.state,
        required this.zip_code,
        required this.business_type})
      : super(key: key);
  final String address, county, state, zip_code, business_type;

  @override
  State<ResultRoute> createState() => _ResultRouteState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ResultRouteState extends State<ResultRoute> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    // Location(serverInfo: _serverInfo,),
    // Result(title: "Result"),
  ];

  Map<String, dynamic> _serverInfo={};

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    serverInfo();
  }

  void serverInfo() async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = //local host
    Uri.parse('http://18.118.105.155/${widget.address}/${widget.county}/${widget.state}/${widget.zip_code}/${widget.business_type}');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      setState(() {
        _serverInfo = jsonResponse;
      });
    }}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}