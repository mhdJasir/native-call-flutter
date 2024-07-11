import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:train/helper/constants.dart';

class CumulativePNL extends StatefulWidget {
  const CumulativePNL({super.key});

  @override
  State<CumulativePNL> createState() => _CumulativePNLState();
}

class _CumulativePNLState extends State<CumulativePNL> {

  List<_SplineAreaData> chartData = <_SplineAreaData>[
    _SplineAreaData(2010, 10.53, 3.3),
    _SplineAreaData(2011, 9.5, 5.4),
    _SplineAreaData(2012, 10, 2.65),
    _SplineAreaData(2013, 9.4, 2.62),
    _SplineAreaData(2014, 5.8, 1.99),
    _SplineAreaData(2015, 4.9, 1.44),
    _SplineAreaData(2016, 4.5, 2),
    _SplineAreaData(2017, 3.6, 1.56),
    _SplineAreaData(2018, 3.43, 2.1),
  ];

  final todaySales = [
    DaySale(time: DateTime(2024, 03, 20, 10, 00, 00), amount: "876"),
    DaySale(time: DateTime(2024, 03, 21, 11, 00, 00), amount: "1500"),
    DaySale(time: DateTime(2024, 03, 22, 12, 00, 00), amount: "2630"),
    DaySale(time: DateTime(2024, 03, 23, 13, 00, 00), amount: "6542"),
    DaySale(time: DateTime(2024, 03, 24, 14, 00, 00), amount: "8962"),
    DaySale(time: DateTime(2024, 03, 25, 15, 00, 00), amount: "12365"),
    DaySale(time: DateTime(2024, 03, 26, 16, 00, 00), amount: "13320"),
    DaySale(time: DateTime(2024, 03, 27, 17, 00, 00), amount: "16986"),
    DaySale(time: DateTime(2024, 03, 28, 18, 00, 00), amount: "17450"),
    DaySale(time: DateTime(2024, 03, 29, 19, 00, 00), amount: "17550"),
    DaySale(time: DateTime(2024, 03, 30, 20, 00, 00), amount: "18900"),
    DaySale(time: DateTime(2024, 03, 31, 21, 00, 00), amount: "23690"),
  ];

  @override
  Widget build(BuildContext context) {
    const Color seriesColor1 = Color.fromRGBO(75, 135, 185, 1);
    return Container  (
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: const Text("Cumulative PNL"),
          ),
          sbh(5),
          // Expanded(
          //   child: SfCartesianChart(
          //     legend: Legend(isVisible: true, opacity: 0.7),
          //     title: ChartTitle(text: 'Inflation rate'),
          //     plotAreaBorderWidth: 0,
          //     primaryXAxis: NumericAxis(
          //         interval: 1,
          //         majorGridLines: const MajorGridLines(width: 0),
          //         edgeLabelPlacement: EdgeLabelPlacement.shift),
          //     primaryYAxis: NumericAxis(
          //         labelFormat: '{value}%',
          //         axisLine: const AxisLine(width: 0),
          //         majorTickLines: const MajorTickLines(size: 0)),
          //     series: _getSplineAreaSeries(),
          //     tooltipBehavior: TooltipBehavior(enable: true),
          //   ),
          // ),
          Expanded(
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              primaryXAxis: NumericAxis(
                  interval: 1,
                  majorGridLines: const MajorGridLines(width: 0),
                  edgeLabelPlacement: EdgeLabelPlacement.shift),
              primaryYAxis: NumericAxis(
                  labelFormat: '{value}%',
                  axisLine: const AxisLine(width: 0),
                  majorTickLines: const MajorTickLines(size: 0)),
              series: [
                SplineAreaSeries<_SplineAreaData, double>(
                  dataSource: chartData,
                  color: seriesColor1.withOpacity(0.6),
                  borderColor: seriesColor1,
                  name: 'India',
                  xValueMapper: (_SplineAreaData sales, _) => sales.year,
                  yValueMapper: (_SplineAreaData sales, _) => sales.y1,
                ),
              ],
              tooltipBehavior: TooltipBehavior(enable: true),
            ),
          ),
        ],
      ),
    );
  }
}

MajorGridLines get majorGridLines =>
    MajorGridLines(width: 0.8, color: Colors.grey.shade200);

class _SplineAreaData {
  _SplineAreaData(this.year, this.y1, this.y2);

  final double year;
  final double y1;
  final double y2;
}

class DaySale {
  final DateTime? time;
  final String? amount;

  DaySale({
    this.time,
    this.amount,
  });

  factory DaySale.fromJson(json) {
    return DaySale(
      amount: json['amount'],
      time: json['time'],
    );
  }
}