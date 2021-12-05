import 'package:flutter/material.dart';
import 'dataSeries.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChart extends StatelessWidget {
  final List<DataSeries> data;

  final title;
  BarChart({required this.data, required this.title});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<DataSeries, String>> series = [
      charts.Series(
          id: "Data",
          data: data,
          domainFn: (DataSeries series, _) => series.label,
          measureFn: (DataSeries series, _) => series.value,
          colorFn: (DataSeries series, _) => series.barColor
      )
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(25),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              Text(
               title,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),

              )
            ],
          ),
        ),
      ),
    );
  }

}