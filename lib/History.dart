import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Location.dart';

class History extends StatefulWidget {
  History({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Map> info = [];

  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
  }

  void getInfo() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<String> temp = _prefs.getStringList('history') ?? [];
    setState(() {
      for (int i = temp.length - 1 ; i >= 0; i--) {
        info.add(convert.jsonDecode(temp[i]));
      }
    });

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
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: info.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Within the `FirstRoute` widget
                          Navigator.push( //connect to different screen
                            context,
                            MaterialPageRoute( //connect different route
                                builder: (context) => Location( //build Location
                                    address: info[index]["Address"],
                                    county: info[index]["County"]!,
                                    state: info[index]["State"]!,
                                    zip_code: info[index]["Zip"],
                                    business_type: info[index]["Business"])),
                          ); },
                        child: Text(info[index]["Business"] +
                            ", " + info[index]["Address"] +
                            ", " + info[index]["Zip"] +
                            ", " + info[index]["County"] +
                            ", " + info[index]["State"]),
                      ),
                  )
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            )),
      ),
    );
  }
}
