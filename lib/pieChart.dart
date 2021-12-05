import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dataSeries.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieCharts extends StatelessWidget {


  final dataMap;

 final colorList;
 final title;
 final centerText;

  PieCharts({required this.dataMap, required this.colorList, required this.title, required this.centerText,});

  @override
  Widget build(BuildContext context) {
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
                child:  PieChart(
                  dataMap: dataMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                  colorList: colorList,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 32,
                  centerText: centerText,
                  legendOptions: LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendShape: BoxShape.circle,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: false,
                    showChartValuesOutside: false,
                    decimalPlaces: 1,

                  ),
                  // gradientList: ---To add gradient colors---
                  // emptyColorGradient: ---Empty Color gradient---
                ),

              )
            ],
          ),
        ),
      ),
    );
  }

}