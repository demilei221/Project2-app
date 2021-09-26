import 'package:flutter/material.dart';

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

  String? dropdownValue ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  value: dropdownValue,
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
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['One', 'Two', 'Free', 'Four']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: County,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'County',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
