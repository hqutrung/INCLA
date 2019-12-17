import 'package:document/models/course.dart';
import 'package:document/models/rate.dart';
import 'package:document/models/ratestatistical.dart';
import 'package:document/models/studentstatistical.dart';
import 'package:document/services/document_firestore.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:provider/provider.dart';

class RateChart extends StatefulWidget {
  @override
  _RateChartState createState() => _RateChartState();
}

class _RateChartState extends State<RateChart> {
  Future<List<Rates>> ratesAsyncer;

  void initState() {
    Course course = Provider.of<Course>(context, listen: false);
    ratesAsyncer = FireStoreHelper().getAllRates(course: course);
    super.initState();
  }

  List<RateStatistical> _getRateStatistical(List<Rates> rates) {
    List<RateStatistical> rateData = List<RateStatistical>();
    double averageRate = 0;
    for (int i = 0; i < rates.length; i++) {
      List<Rate> sessionRates = rates[i].rates;
      if (sessionRates == null) {
        print('loai dc 1 em');
        continue;
      }
      print(sessionRates.length.toString() + ' jhaha');
      for (int j = 0; j < sessionRates.length; j++)
        averageRate += sessionRates[j].star;
      averageRate =
          (sessionRates.length == 0) ? 0 : (averageRate / sessionRates.length);
      rateData.add(RateStatistical(averageRate, rates[i].timestamp));
    }
    return rateData;
  }

  List<Series<RateStatistical, DateTime>> _getChartSeries(
      List<RateStatistical> rateStats) {
    return [
      Series(
        data: rateStats,
        id: 'RateChart',
        domainFn: (RateStatistical ratedata, _) => ratedata.date,
        measureFn: (RateStatistical ratedata, _) => ratedata.rate,
        colorFn: (_, __) => MaterialPalette.red.shadeDefault,
      )
    ];
  }



  Widget rateChart() => Container(
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
                FutureBuilder<List<Rates>>(
                    future: ratesAsyncer,
                    initialData: [],
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data.length == 0)
                          return Text('Thiếu dữ liệu để đánh giá');
                        return Expanded(
                          child: TimeSeriesChart(
                            _getChartSeries(_getRateStatistical(snapshot.data)),
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
                        );
                      } else {
                        return Text('Loading...');
                      }
                    })
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
            rateChart(),
            studentchart(),
          ],
        ),
      ),
    );
  }
}
