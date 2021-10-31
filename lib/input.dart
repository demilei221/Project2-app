import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'Location.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';

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
  String? dropdownCounty;
  String? dropdownState;
  String? _selectedValue;

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
              Padding(
                padding: EdgeInsets.all(8),
                child: CustomSearchableDropDown(
                  items: _states,
                  label: 'Select State',
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  // prefixIcon: Padding(
                  //   padding: const EdgeInsets.all(0.0),
                  //   child: Icon(Icons.search),
                  // ),
                  dropDownMenuItems: _states?.map((item) {
                        return item;
                      })?.toList() ??
                      [],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        dropdownState = value;
                        dropdownCounty = null;
                        county();
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: CustomSearchableDropDown(
                  items: _county,
                  label: 'Select County',
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  // prefixIcon: Padding(
                  //   padding: const EdgeInsets.all(0.0),
                  //   child: Icon(Icons.search),
                  // ),
                  dropDownMenuItems: _county?.map((item) {
                        return item;
                      })?.toList() ??
                      [],
                  onChanged: (value) {
                    if (value != null) {
                      dropdownCounty = value;
                    }
                  },
                ),
              ),
              ElevatedButton(
                // style: style,
                onPressed: () {
                  // Within the `FirstRoute` widget

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Location(
                            address: Address.text,
                            county: dropdownCounty!,
                            state: dropdownState!,
                            zip_code: zip.text,
                            business_type: Business.text)),
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
    var url = Uri.parse('http://10.0.2.2:5000/States');

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
    var url = Uri.parse('http://10.0.2.2:5000/${dropdownState}');

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
