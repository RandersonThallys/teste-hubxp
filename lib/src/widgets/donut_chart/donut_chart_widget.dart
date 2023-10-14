// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:teste_hub/src/core/theme/colors.dart';
import 'package:teste_hub/src/pages/home_store.dart';
import 'package:teste_hub/src/widgets/donut_chart/center_content.dart';

import 'package:teste_hub/src/models/data_donut_chart.dart';
import 'package:teste_hub/src/widgets/donut_chart/donut_chart_legend.dart';

class DonutChartWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final List<DataDonutChart> data;
  final HomeStore store;

  const DonutChartWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.data,
    required this.store,
  }) : super(key: key);

  List<PieChartSectionData> sections() {
    return List.generate(data.length, (index) {
      final bool isTouched =
          store.selectedDonutChart.value?.label == data[index].label;
      final double radius = isTouched ? 40 : 30;

      return PieChartSectionData(
          value: data[index].value,
          showTitle: false,
          radius: radius,
          color: AppColors().chartColors[index]);
    });
  }

  PieTouchData pieTouchData() {
    return PieTouchData(
      touchCallback: (touch, response) {
        if (response != null &&
            response.touchedSection!.touchedSectionIndex != -1) {
          store.setSelectedDonutChart(
              data[response.touchedSection!.touchedSectionIndex]);
        } else {
          store.setSelectedDonutChart(null);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DataDonutChart?>(
        valueListenable: store.selectedDonutChart,
        builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                          PieChartData(
                            sectionsSpace: 5,
                            centerSpaceRadius: 140,
                            pieTouchData: pieTouchData(),
                            sections: sections()
                          )
                      ),
                      CenterContent(
                          title: title,
                          subTitle: subTitle,
                          data: data,
                          store: store
                      )
                    ],
                  )
              ),
              DonutChartLegend(data: data)
            ],
          );
        });
  }
}
