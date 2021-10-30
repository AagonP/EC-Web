import 'dart:math';

import 'package:ecommerce_admin_tut/provider/tables.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SalesChart extends StatefulWidget {
  final TablesProvider tablesProvider;
  final currentDay = 31;
  final currentMonth = 10;

  SalesChart({Key key, this.tablesProvider}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SalesChartState();
}

class SalesChartState extends State<SalesChart> {
  bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    List<double> revenuesThisWeek = widget.tablesProvider.revenuesThisWeek;
    List<double> revenuesThisMonth = widget.tablesProvider.revenuesThisMonth;

    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: [
              Color(0xff2c274c),
              Color(0xff46426c),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 37,
                ),
                const Text(
                  'Sales chart',
                  style: TextStyle(
                    color: Color(0xff827daa),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  isShowingMainData ? 'Sales this week' : 'Sales of this month',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 30, 0),
                    child: LineChart(
                      isShowingMainData
                          ? sampleData1(widget.currentDay, revenuesThisWeek)
                          : sampleData2(revenuesThisMonth),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1(int currentDay, List<double> revenuesThisWeek) {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            return "${value.toInt().toString()}/${widget.currentMonth}";
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            if (value.toInt() % 50 == 0) {
              return "${value.toString()} \$";
            }
            return "";
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: (currentDay - 6).toDouble(),
      maxX: currentDay.toDouble(),
      maxY: revenuesThisWeek.reduce(max),
      minY: revenuesThisWeek.reduce(min),
      lineBarsData: linesBarData1(revenuesThisWeek),
    );
  }

  List<LineChartBarData> linesBarData1(List<double> revenuesThisWeek) {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: List.generate(
          revenuesThisWeek.length,
          (index) => FlSpot((widget.currentDay - 6 + index).toDouble(),
              revenuesThisWeek[index])),
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
    ];
  }

  LineChartData sampleData2(List<double> revenuesThisMonth) {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            if (value.toInt() % 5 == 0)
              return "${value.toInt().toString()}//${widget.currentMonth}";
            return "";
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            if (value.toInt() % 50 == 0) {
              return "${value.toString()} \$";
            }
            return "";
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 1,
      maxX: 31,
      maxY: revenuesThisMonth.reduce(max),
      minY: revenuesThisMonth.reduce(min),
      lineBarsData: linesBarData2(revenuesThisMonth),
    );
  }

  List<LineChartBarData> linesBarData2(List<double> revenuesThisMonth) {
    return [
      LineChartBarData(
        spots: List.generate(
            revenuesThisMonth.length,
            (index) =>
                FlSpot((index + 1).toDouble(), revenuesThisMonth[index])),
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x444af699),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          const Color(0x33aa4cfc),
        ]),
      ),
    ];
  }
}
