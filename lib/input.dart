import 'package:flutter/material.dart';


import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import 'Location.dart';




class InputPage extends StatefulWidget {
  InputPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _InputPageState createState() => _InputPageState();

}

class _InputPageState extends State<InputPage> {
  TextEditingController Business = TextEditingController();
  TextEditingController County = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController zip = TextEditingController();
  List<String> _states = [];
  List<String> _county = [];
  String? dropdownCounty ;
  String? dropdownState ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    states();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: Business,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Type of Business',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: Address,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: zip,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Zip Code',
                  ),
                ),
              ),
              DropdownButton<String>(
                  value: dropdownState,
                  hint: Text('Select State'),
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownState = newValue!;
                      dropdownCounty = null;
                      county();
                    });
                  },
                  items: _states
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                    value: dropdownCounty,
                    hint: Text('Select County'),
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: dropdownState == null ? null:
                        (String? newValue) {
                      setState(() {
                        dropdownCounty = newValue!;
                      });
                    },
                    items: _county
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()),
              ),
              ElevatedButton(
                // style: style,
                onPressed: () {
                  // Within the `FirstRoute` widget

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Location(
                          address: Address.text,
                          county: dropdownCounty!,
                          state: dropdownState!,
                          zip_code: zip.text,
                          business_type: Business.text
                      )),
                    );

                },
                child: const Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }



  void states() async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url =
    Uri.parse('http://10.0.2.2:5000/States');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      setState(() {
        _states = (jsonResponse as List).map((e) => e.toString()).toList();
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }


  void county() async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url =
    Uri.parse('http://10.0.2.2:5000/${dropdownState}');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      setState(() {
        _county = (jsonResponse as List).map((e) => e.toString()).toList();
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

}
