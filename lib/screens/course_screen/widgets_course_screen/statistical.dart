import 'package:document/models/attendance.dart';
import 'package:document/models/course.dart';
import 'package:document/models/rate.dart';
import 'package:document/models/ratestatistical.dart';
import 'package:document/models/studentstatistical.dart';
import 'package:document/models/user_infor.dart';
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
  Future<List<Attendance>> attendanceAsyncer;

  void initState() {
    Course course = Provider.of<Course>(context, listen: false);
    ratesAsyncer = FireStoreHelper().getAllRates(course: course);
    attendanceAsyncer = FireStoreHelper().getAllAttendance(course: course);
    super.initState();
  }

  List<RateStatistical> _getRateStatistical(List<Rates> rates) {
    List<RateStatistical> rateData = List<RateStatistical>();
    double averageRate = 0;
    for (int i = 0; i < rates.length; i++) {
      List<Rate> sessionRates = rates[i].rates;
      if (sessionRates == null) continue;
      for (int j = 0; j < sessionRates.length; j++)
        averageRate += sessionRates[j].star;
      averageRate =
          (sessionRates.length == 0) ? 0 : (averageRate / sessionRates.length);
      rateData.add(RateStatistical(averageRate, rates[i].timestamp));
    }
    return rateData;
  }

  List<Series<RateStatistical, DateTime>> _getRateChartSeries(
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

  List<StudentStatistical> _getAttendanceStatistical(
      List<Attendance> attendances) {
    List<StudentStatistical> attendanceData = List<StudentStatistical>();

    for (int i = 0; i < attendances.length; i++) {
      int extra =
          (attendances[i].online == null) ? 0 : attendances[i].online.length;
      attendanceData.add(StudentStatistical(extra, attendances[i].timestamp));
    }
    return attendanceData;
  }

  List<Series<StudentStatistical, DateTime>> _getAttendanceChartSeries(
      List<StudentStatistical> attendanceData) {
    return [
      Series(
        data: attendanceData,
        id: 'RateChart',
        domainFn: (StudentStatistical student, _) {
          print(student.date);
          return student.date;
        },
        measureFn: (StudentStatistical student, _) => student.quantity,
        colorFn: (_, __) => MaterialPalette.green.shadeDefault,
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
                            _getRateChartSeries(
                                _getRateStatistical(snapshot.data)),
                            domainAxis: DateTimeAxisSpec(
                              tickFormatterSpec: AutoDateTimeTickFormatterSpec(
                                day: TimeFormatterSpec(
                                  format: 'dd',
                                  transitionFormat: 'dd MMM',
                                ),
                              ),
                            ),
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
                FutureBuilder<List<Attendance>>(
                  future: attendanceAsyncer,
                  initialData: [],
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data.length > 0)
                        return Expanded(
                          child: TimeSeriesChart(
                            _getAttendanceChartSeries(
                                _getAttendanceStatistical(snapshot.data)),
                            defaultRenderer:
                                LineRendererConfig<DateTime>(includeArea: true),
                            animationDuration: const Duration(seconds: 1),
                            domainAxis: DateTimeAxisSpec(
                              showAxisLine: true,
                              tickFormatterSpec: AutoDateTimeTickFormatterSpec(
                                day: TimeFormatterSpec(
                                  format: 'dd',
                                  transitionFormat: 'dd MMM',
                                ),
                              ),
                            ),
                            animate: true,
                            // dateTimeFactory: const LocalDateTimeFactory(),
                            behaviors: [
                              ChartTitle('Số lượng',
                                  behaviorPosition: BehaviorPosition.start),
                              ChartTitle('Ngày',
                                  behaviorPosition: BehaviorPosition.bottom),
                            ],
                          ),
                        );
                      else
                        return const Text('Thiếu dữ liệu thống kê');
                    } else
                      return const Text('Loading...');
                  },
                )
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          rateChart(),
          studentchart(),
        ],
      ),
    );
  }
}
