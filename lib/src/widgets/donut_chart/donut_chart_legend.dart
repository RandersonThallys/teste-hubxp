import 'package:flutter/material.dart';
import 'package:teste_hub/src/core/theme/colors.dart';
import 'package:teste_hub/src/models/data_donut_chart.dart';

class DonutChartLegend extends StatelessWidget {
  final List<DataDonutChart> data;

  const DonutChartLegend({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.only(top: 10),
      child: Wrap(
        spacing: 15,
        alignment: WrapAlignment.center,
        children: [
          ...data
              .asMap()
              .map((i, element) => MapEntry(
              i,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle_rounded,
                      color: AppColors().chartColors[i]),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(element.label),
                  )
                ],
              )))
              .values
              .toList()
        ],
      ),
    );
  }
}
