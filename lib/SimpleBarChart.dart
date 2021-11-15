/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'Child.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  List<UserInsights> map;
  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData(List<UserInsights> map) {
    return new SimpleBarChart(
      _createSampleData(map),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      // domainAxis: charts.OrdinalAxisSpec(
      //     renderSpec: charts.SmallTickRendererSpec(
      //         minimumPaddingBetweenLabelsPx: 0,
      //         labelAnchor: charts.TickLabelAnchor.centered,
      //         labelStyle: charts.TextStyleSpec(
      //           fontSize: 10,
      //           color: charts.MaterialPalette.black,
      //         ),
      //         labelRotation: 60,
      //         // Change the line colors to match text color.
      //         lineStyle:
      //             charts.LineStyleSpec(color: charts.MaterialPalette.black))),
    );
  }

  static List<charts.Series<UserInsights, String>> _createSampleData(
      List<UserInsights> map) {
    // var map = {
    //   "Phonics": 0.6666666667,
    //   "Phonemes": 0.8333333333,
    //   "Vocabulary": 0.5,
    //   "Instruction": 0.5,
    //   "Reading": 0.3333333333
    // };

    // List<UserInsights> users = [];
    // for (var key in map.keys) {
    //   UserInsights user = new UserInsights(key, map[key]);
    //   users.add(user);
    // }
    return [
      new charts.Series<UserInsights, String>(
        id: 'Sales',
        colorFn: (UserInsights sales, __) => sales.data < 0.5
            ? charts.MaterialPalette.red.shadeDefault
            : charts.MaterialPalette.blue.shadeDefault,
        domainFn: (UserInsights sales, _) => sales.label,
        measureFn: (UserInsights sales, _) => sales.data,
        data: map,
      )
    ];
  }
}
