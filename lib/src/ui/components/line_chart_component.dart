// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_evento/src/models/price_point_model.dart';
import 'package:my_evento/src/utils/functions_utils.dart';
import 'package:my_evento/values/k_colors.dart';

class LineChartComponent extends StatelessWidget {
  List<PricePointModel> points;
  double? maxX;
  double? maxY;
  List<DateTime?> dates = [];

  LineChartComponent(this.points, {this.maxX, this.maxY, super.key}) {
    for (PricePointModel point in points) {
      dates.add(point.date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minY: 0,
        minX: 0,
        titlesData: _titlesData(),
        borderData: _borderData(),
        gridData: FlGridData(
          show: false,
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: KGray_L1.withOpacity(0.2),
            fitInsideHorizontally: true,
            fitInsideVertically: true,
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            gradient: const LinearGradient(colors: [KPrimary, KPrimary_L1]),
            spots: points
                .map(
                  (point) => FlSpot(point.x, point.y),
                )
                .toList(),
            isCurved: false,
            dotData: FlDotData(
              show: points.length > 1 ? false : true,
            ),
          ),
        ],
      ),
    );
  }

  _borderData() {
    return FlBorderData(
      border: Border(
        bottom: BorderSide(
          color: KWhite,
          width: 2,
        ),
        /*left: BorderSide(
          color: ThemeManager().getTextColor(),
          width: 2,
        ), */
      ),
    );
  }

  _titlesData() {
    return FlTitlesData(
      show: true,
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 3.5,
          getTitlesWidget: (value, meta) {
            return Center(
              child: Text(
                "",
                style: TextStyle(
                  color: KBackgroundBlue,
                ),
                textAlign: TextAlign.end,
              ),
            );
          },
          showTitles: true,
        ),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 3.5,
          showTitles: true,
          getTitlesWidget: (value, meta) {
            return Text(
              "",
              style: TextStyle(color: KBackgroundBlue),
            );
          },
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 25,
          showTitles: true,
          getTitlesWidget: (value, meta) {
            return Center(
              child: Text(
                points.indexWhere((element) => element.x == value) != -1
                    ? dateFormat(
                        dates[
                            points.indexWhere((element) => element.x == value)],
                        false)
                    : "",
                //(value).toStringAsFixed(0),
                style: TextStyle(color: KWhite),
              ),
            );
          },
        ),
      ),
    );
  }
}
