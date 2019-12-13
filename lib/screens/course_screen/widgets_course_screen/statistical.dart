import 'package:document/models/ratestatistical.dart';
import 'package:document/models/studentstatistical.dart';
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

  Widget ratechart() => Container(
        height: 250,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Thống kê đánh giá",
                  style: Theme.of(context).textTheme.body2,
                ),
                Expanded(
                  child: TimeSeriesChart(
                    rateseris,
                    animate: true,
                    dateTimeFactory: LocalDateTimeFactory(),
                    animationDuration: Duration(seconds: 1),
                    defaultRenderer: LineRendererConfig(
                      includeArea: true,
                    ),
                    behaviors: [
                      ChartTitle('Đánh giá',
                          behaviorPosition: BehaviorPosition.start),
                      ChartTitle('Ngày',
                          behaviorPosition: BehaviorPosition.bottom),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  static List<StudentStatistical> attendantdata = [
    StudentStatistical(15, DateTime(2019, 10, 11)),
    StudentStatistical(14, DateTime(2019, 10, 12)),
    StudentStatistical(5, DateTime(2019, 10, 13)),
    StudentStatistical(12, DateTime(2019, 10, 14)),
    StudentStatistical(15, DateTime(2019, 10, 15)),
    StudentStatistical(5, DateTime(2019, 10, 16)),
    StudentStatistical(15, DateTime(2019, 10, 17)),
    StudentStatistical(14, DateTime(2019, 10, 18)),
    StudentStatistical(15, DateTime(2019, 10, 19)),
    StudentStatistical(15, DateTime(2019, 10, 20)),
    StudentStatistical(15, DateTime(2019, 10, 21)),
  ];

  static List<StudentStatistical> absentdata = [
    StudentStatistical(21, DateTime(2019, 10, 11)),
    StudentStatistical(4, DateTime(2019, 10, 12)),
    StudentStatistical(15, DateTime(2019, 10, 13)),
    StudentStatistical(12, DateTime(2019, 10, 14)),
    StudentStatistical(5, DateTime(2019, 10, 15)),
    StudentStatistical(5, DateTime(2019, 10, 16)),
    StudentStatistical(15, DateTime(2019, 10, 17)),
    StudentStatistical(4, DateTime(2019, 10, 18)),
    StudentStatistical(15, DateTime(2019, 10, 19)),
    StudentStatistical(5, DateTime(2019, 10, 20)),
    StudentStatistical(15, DateTime(2019, 10, 21)),
  ];

List<Series<StudentStatistical, DateTime>> studentseris = [
    Series(
      data: attendantdata,
      id: 'AttendantChart',
      domainFn: (StudentStatistical attendantdata, _) => attendantdata.date,
      measureFn: (StudentStatistical attendantdata, _) => attendantdata.soluong,
      colorFn: (_, __) => MaterialPalette.green.shadeDefault,
    ),
    Series(
      data: absentdata,
      id: 'AbsentChart',
      domainFn: (StudentStatistical absentdata, _) => absentdata.date,
      measureFn: (StudentStatistical absentdata, _) => absentdata.soluong,
      colorFn: (_, __) => MaterialPalette.red.shadeDefault,
    )
  ];



  Widget studentchart() => Container(
        height: 250,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Thống kê điểm danh",
                  style: Theme.of(context).textTheme.body2,
                ),
                Expanded(
                  child: TimeSeriesChart(
                    studentseris,
                    animate: true,
                    dateTimeFactory: LocalDateTimeFactory(),
                    animationDuration: Duration(seconds: 1),
                    defaultRenderer: LineRendererConfig(
                      includeArea: true,
                    ),
                    behaviors: [
                      ChartTitle('Số lượng',
                          behaviorPosition: BehaviorPosition.start),
                      ChartTitle('Ngày',
                          behaviorPosition: BehaviorPosition.bottom),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ratechart(),
            studentchart(),
          ],
        ),
      ),
    );
  }
}
