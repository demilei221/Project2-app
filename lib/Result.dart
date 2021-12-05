import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:untitled/pieChart.dart';
import 'barChart.dart';
import 'dataSeries.dart';

class Result extends StatefulWidget {
  Result({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };

  final colorList = <Color>[
    Color(0xfffdcb6e),
    Color(0xff0984e3),
    Color(0xfffd79a8),
    Color(0xffe17055),
    Color(0xff6c5ce7),
  ];


  final List<DataSeries> data = [

    DataSeries(
      label: "2017",
      value: 40000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    DataSeries(
      label: "2018",
      value: 50000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    DataSeries(
      label: "2019",
      value: 40000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    DataSeries(
      label: "2020",
      value: 35000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    DataSeries(
      label: "2021",
      value: 45000,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
  ];
  
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
             PieCharts(dataMap: dataMap, colorList: colorList, title: "Growth in the Flutter Community", centerText: "HYBRID",),
              BarChart( data: data, title:  "Yearly Growth in the Flutter Community",)

            ],
          ),
        ),
      ),
    );
  }
}