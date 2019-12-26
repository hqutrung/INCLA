import 'dart:math';

import 'package:document/models/attendance.dart';
import 'package:document/models/course.dart';
import 'package:document/models/rate.dart';
import 'package:document/models/ratestatistical.dart';
import 'package:document/models/studentstatistical.dart';
import 'package:document/models/user_infor.dart';
import 'package:document/services/firestore_helper.dart';
import 'package:document/utils/ConvertDateTime.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/src/text_element.dart';
import 'package:charts_flutter/src/text_style.dart' as style;

class RateChart extends StatefulWidget {
  @override
  _RateChartState createState() => _RateChartState();
}

class _RateChartState extends State<RateChart> {
  Future<List<Rates>> ratesAsyncer;
  Future<List<Attendance>> attendanceAsyncer;
  DateTime _time = DateTime.now();
  double _measures = 0;

  DateTime _timestudent = DateTime.now();
  int _measuresstudent = 0;

  _onSelectionChanged(SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    print(selectedDatum[0].datum.rate);
    DateTime time = DateTime.now();
    double measures = 0;

    // We get the model that updated with a list of [SeriesDatum] which is
    // simply a pair of series & datum.
    //
    // Walk the selection updating the measures map, storing off the sales and
    // series name for each selection point.
    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.date;
      measures = selectedDatum[0].datum.rate;
    }
    // Request a build.
    setState(() {
      _time = time;
      print(_time);
      _measures = measures;
    });
  }

  _onStudentSelectionChanged(SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    DateTime time = DateTime.now();
    int measures = 0;

    // We get the model that updated with a list of [SeriesDatum] which is
    // simply a pair of series & datum.
    //
    // Walk the selection updating the measures map, storing off the sales and
    // series name for each selection point.
    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.date;
      measures = selectedDatum[0].datum.quantity;
    }
    // Request a build.
    setState(() {
      _timestudent = time;
      _measuresstudent = measures;
    });
  }

  void initState() {
    Course course = Provider.of<Course>(context, listen: false);
    ratesAsyncer = FireStoreHelper().getAllRates(course: course);
    attendanceAsyncer = FireStoreHelper().getAllAttendance(course: course);
    super.initState();
  }

  List<RateStatistical> _getRateStatistical(List<Rates> rates) {
    List<RateStatistical> rateData = List<RateStatistical>();

    for (int i = 0; i < rates.length; i++) {
      double averageRate = 0;
      List<Rate> sessionRates = rates[i].rates;
      if (sessionRates == null) continue;
      for (int j = 0; j < sessionRates.length; j++) {
        averageRate += sessionRates[j].star;
      }
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
          return student.date;
        },
        measureFn: (StudentStatistical student, _) => student.quantity,
        colorFn: (_, __) => MaterialPalette.green.shadeDefault,
      )
    ];
  }

  Widget rateChart() => Container(
        height: 300,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<Rates>>(
                future: ratesAsyncer,
                initialData: [],
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null || snapshot.data.length == 0)
                      return Text('Thiếu dữ liệu để đánh giá');
                    return Column(
                      children: <Widget>[
                        Text('Thống kê đánh giá'),
                        Expanded(
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
                            primaryMeasureAxis: NumericAxisSpec(
                              showAxisLine: true,
                              renderSpec: GridlineRendererSpec(),
                              tickProviderSpec: BasicNumericTickProviderSpec(
                                dataIsInWholeNumbers: true,
                                desiredTickCount: 6,
                                desiredMinTickCount: 6,
                              ),
                            ),
                            animate: true,
                            selectionModels: [
                              SelectionModelConfig(
                                type: SelectionModelType.info,
                                changedListener: _onSelectionChanged,
                              )
                            ],
                            dateTimeFactory: LocalDateTimeFactory(),
                            animationDuration: Duration(seconds: 1),
                            defaultRenderer: LineRendererConfig(
                                includeArea: true, includePoints: true),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text('Ngày: ' +
                                ConvertDateTimeToBirthday(_time).toString()),
                            Row(
                              children: <Widget>[
                                Text('Trung bình: ' + _measures.toString()),
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
      );

  Widget studentchart() => Container(
        height: 250,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<Attendance>>(
              future: attendanceAsyncer,
              initialData: [],
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data.length > 0)
                    return Column(
                      children: <Widget>[
                        Text('Thống kê điểm danh'),
                        Expanded(
                          child: TimeSeriesChart(
                            _getAttendanceChartSeries(
                                _getAttendanceStatistical(snapshot.data)),

                            defaultRenderer: LineRendererConfig<DateTime>(
                                includeArea: true, includePoints: true),
                            animationDuration: const Duration(seconds: 1),
                            primaryMeasureAxis: NumericAxisSpec(
                              showAxisLine: true,
                              renderSpec: GridlineRendererSpec(),
                              tickProviderSpec: BasicNumericTickProviderSpec(
                                  desiredTickCount: 10,
                                  desiredMinTickCount: 10),
                            ),

                            domainAxis: DateTimeAxisSpec(
                              showAxisLine: true,
                              tickFormatterSpec: AutoDateTimeTickFormatterSpec(
                                day: TimeFormatterSpec(
                                  format: 'dd/MM',
                                  transitionFormat: 'dd/MM',
                                ),
                              ),
                            ),
                            animate: true,
                            // dateTimeFactory: const LocalDateTimeFactory(),
                            selectionModels: [
                              SelectionModelConfig(
                                type: SelectionModelType.info,
                                changedListener: _onStudentSelectionChanged,
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text('Ngày: ' +
                                ConvertDateTimeToBirthday(_timestudent)
                                    .toString()),
                            Text('Có mặt: ' +
                                _measuresstudent.toString() +
                                ' sinh viên'),
                          ],
                        )
                      ],
                    );
                  else
                    return const Text('Thiếu dữ liệu thống kê');
                } else
                  return const Center(child: CircularProgressIndicator());
              },
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
