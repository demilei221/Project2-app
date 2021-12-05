import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:untitled/pieChart.dart';
import 'barChart.dart';
import 'dataSeries.dart';

class Result extends StatefulWidget {
  Result({Key? key, required this.title, required this.serverInfo}) : super(key: key);

  final String title;
  Map<String, dynamic> serverInfo;

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Map<String, double> dataMap = {};
  final colorList = <Color>[
    Color(0xfffdcb6e),
    Color(0xff0984e3),
    Color(0xfffd79a8),
    Color(0xffe17055),
    Color(0xff6c5ce7),
  ];


  List<DataSeries> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    demoStrToDouble();
    data = [DataSeries(
      label: "this area",
      value: int.parse(widget.serverInfo['income_zip_code']),
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    DataSeries(
    label: "county",
    value:  int.parse(widget.serverInfo['income_county']),
    barColor: charts.ColorUtil.fromDartColor(Colors.green),
    )];
  }
  void demoStrToDouble() {
    setState(() {
      widget.serverInfo['demographic'].forEach((key, value) {
        print('**********************');
        print(value);
        if (key != 'pacific' ) dataMap[key] = double.parse(value);

      });
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
          child: ListView(

            children: <Widget>[
              BarChart( data: data, title:  "Income",),

                      Text(
                          'Average income of this area: \$' +
                              widget.serverInfo['income_zip_code'],
                          style: TextStyle(fontSize: 18)),
                      Text(
                          'Average income of this county: \$' +
                              widget.serverInfo['income_county'],
                          style: TextStyle(fontSize: 18)),
                      Text(
                          'Poverty Rate: ' +
                              widget.serverInfo['poverty_county'] +
                              "%",
                          style: TextStyle(fontSize: 18)),

                      SizedBox(height: 5),


             PieCharts(dataMap:  dataMap, colorList: colorList, title: "Demographic", centerText: "",),
              Text('Transportation: ',
                  style: TextStyle(fontSize: 18)),
              widget.serverInfo['walkscore'] != null
                  ? Text(
                  "                        Walk: " +
                      widget.serverInfo['walkscore'].toString() +
                      ' - ' +
                      widget.serverInfo['description'],
                  style: TextStyle(fontSize: 18))
                  : SizedBox(),
              widget.serverInfo['bikescore'] != null
                  ? Text(
                  "                        Bike: " +
                      widget.serverInfo['bikescore'].toString() +
                      ' - ' +
                      widget.serverInfo['bikeDescription'],
                  style: TextStyle(fontSize: 18))
                  : SizedBox(),
              widget.serverInfo['transitscore'] != null
                  ? Text(
                  "                        Transport: " +
                      widget.serverInfo['transitscore'].toString() +
                      ' - ' +
                      widget.serverInfo['transitDescription'],
                  style: TextStyle(fontSize: 18))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}