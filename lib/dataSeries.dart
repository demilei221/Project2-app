import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class DataSeries {
  final String label;
  final int value;
  final charts.Color barColor;

  DataSeries(
      {
        required this.label,
        required this.value,
        required this.barColor
      }
      );
}