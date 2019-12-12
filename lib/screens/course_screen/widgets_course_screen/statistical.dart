import 'package:document/models/ratestatistical.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';

class RateChart extends StatefulWidget {
  @override
  _RateChartState createState() => _RateChartState();
}

class _RateChartState extends State<RateChart> {
  static List<RateStatistical> ratedata = [
    RateStatistical(5, DateTime(2019, 10, 11)),
    RateStatistical(4, DateTime(2019, 10, 12)),
    RateStatistical(5, DateTime(2019, 10, 13)),
    RateStatistical(2.4, DateTime(2019, 10, 14)),
    RateStatistical(5, DateTime(2019, 10, 15)),
    RateStatistical(5, DateTime(2019, 10, 16)),
    RateStatistical(5, DateTime(2019, 10, 17)),
    RateStatistical(4, DateTime(2019, 10, 18)),
    RateStatistical(5, DateTime(2019, 10, 19)),
    RateStatistical(5, DateTime(2019, 10, 20)),
    RateStatistical(5, DateTime(2019, 10, 21)),
  ];
  List<Series<RateStatistical, DateTime>> rateseris = [
    Series(
      data: ratedata,
      id: 'RateChart',
      domainFn: (RateStatistical ratedata, _) => ratedata.date,
      measureFn: (RateStatistical ratedata, _) => ratedata.rate,
      colorFn: (_, __) => MaterialPalette.red.shadeDefault,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Tổng kết đánh giá",
                        style: Theme.of(context).textTheme.body2,
                      ),
                      Expanded(
                        child: TimeSeriesChart(rateseris, animate: true),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
