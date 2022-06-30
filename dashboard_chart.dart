import 'dart:async';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '/utils/constants.dart';

class LineChartSample10 extends StatefulWidget {
  const LineChartSample10({Key? key}) : super(key: key);

  @override
  _LineChartSample10State createState() => _LineChartSample10State();
}

class _LineChartSample10State extends State<LineChartSample10> {
  final limitCount = 200;
  final points = <FlSpot>[];

  double xValue = 0;
  double step = 0.1;

  late Timer timer;
  late Stopwatch stopwatch;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      if (timer.tick <= 100) {
        while (points.length > limitCount) {
          points.removeAt(0);
        }
        setState(() {
          points.add(FlSpot(xValue, xValue * sin(xValue)));
        });
        xValue += step;
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return points.isNotEmpty
        ? Stack(
            children: [
              Positioned(
                child: FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child: Card(
                    margin: const EdgeInsets.only(left: defaultPadding),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultPadding / 2),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: SorugoColors.defaultLightGrey,
                        borderRadius: BorderRadius.circular(defaultPadding / 2),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 4,
                        vertical: defaultPadding / 2,
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.history_toggle_off,
                            color: Colors.purpleAccent,
                          ),
                          SizedBox(width: defaultPadding / 2),
                          Text(
                            "Aktivite",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                top: 0,
                left: 0,
              ),
              SizedBox(
                width: double.infinity,
                height: 150,
                child: LineChart(
                  LineChartData(
                    minY: -10,
                    maxY: 10,
                    minX: points.first.x,
                    maxX: points.last.x,
                    lineTouchData: LineTouchData(enabled: true),
                    clipData: FlClipData.all(),
                    gridData: FlGridData(
                      show: false,
                      drawVerticalLine: false,
                    ),
                    lineBarsData: [
                      line(points),
                    ],
                    titlesData: FlTitlesData(
                      show: false,
                    ),
                  ),
                ),
              )
            ],
          )
        : Container();
  }

  LineChartBarData line(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: FlDotData(
        show: false,
      ),
      shadow: const Shadow(
        color: Colors.purple,
        blurRadius: 10,
      ),
      gradient: const LinearGradient(
          colors: [Colors.pinkAccent, Colors.pink, Colors.purpleAccent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.1, 0.5, 1.0]),
      barWidth: 4,
      isCurved: true,
    );
  }
}
