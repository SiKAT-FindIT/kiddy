// Import Packages
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Import Styles
import 'package:kiddy/shared/theme.dart';

// Import Widgets
import 'package:kiddy/ui/widgets/custom_card.dart';
import 'package:kiddy/ui/widgets/header.dart';

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final int y;
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Say hi
    Widget sayHi() {
      return Row(
        children: [
          Text(
            'Hi ',
            style: whiteText.copyWith(
              fontSize: 20,
            ),
          ),
          Text(
            'Mrs. Evans',
            style: whiteText.copyWith(fontSize: 20, fontWeight: bold),
          ),
        ],
      );
    }

    // Current Task
    Widget currentTask() {
      return CustomCard(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Text(
              '09:41',
              style: darkGreyText.copyWith(
                fontSize: 24,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Next Schedule',
                    style: darkGreyText.copyWith(
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    'Pick Up Baim from School',
                    overflow: TextOverflow.ellipsis,
                    style: darkGreyText.copyWith(
                      fontSize: 12,
                      fontWeight: semibold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    // Sleep Chart
    Widget sleepChart() {
      return CustomCard(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kana\'s Sleep Tracker',
                  style: darkGreyText.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                ),
                Text(
                  '12/02/2024',
                  style: darkGreyText.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 36),
                  child: Column(
                    children: [
                      Text(
                        '${double.parse('${8 / 24 * 100}').toStringAsFixed(2)}%',
                        style: darkGreyText.copyWith(
                          fontSize: 28,
                          fontWeight: bold,
                        ),
                      ),
                      Text(
                        '12 Hours',
                        style: darkGreyText.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                ),
                SfCircularChart(
                  tooltipBehavior: TooltipBehavior(enable: true),
                  legend: const Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                  ),
                  palette: [
                    darkYellowColor,
                    blueColor,
                  ],
                  series: <CircularSeries<ChartData, String>>[
                    DoughnutSeries<ChartData, String>(
                      dataSource: [
                        ChartData('AWAKE', 12),
                        ChartData('SLEEP', 8),
                      ],
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      innerRadius: '70%',
                      name: 'Sleep Tracker',
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      );
    }

    // render body
    Widget body() {
      return SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(
            top: 64,
            bottom: 100,
            right: 28,
            left: 28,
          ),
          children: [
            sayHi(),
            currentTask(),
            sleepChart(),
          ],
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Header(
            color: darkGreenColor,
          ),
          body(),
        ],
      ),
    );
  }
}
