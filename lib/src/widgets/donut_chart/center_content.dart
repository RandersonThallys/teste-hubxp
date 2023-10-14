import 'package:flutter/material.dart';
import 'package:teste_hub/src/core/theme/colors.dart';
import 'package:teste_hub/src/core/utils/formatting.dart';
import 'package:teste_hub/src/pages/home_store.dart';
import 'package:teste_hub/src/models/data_donut_chart.dart';

class CenterContent extends StatelessWidget {
  final String title;
  final String subTitle;
  final List<DataDonutChart> data;
  final HomeStore store;

  const CenterContent(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.data,
      required this.store})
      : super(key: key);

  double getTotalValue() {
    double value = 0;

    for (var element in data) {
      value += element.value;
    }

    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(store.selectedDonutChart.value?.label ?? title,
            style: TextStyle(fontSize: 24, color: AppColors().grey)),
        Text(
            Formatting().value(
                store.selectedDonutChart.value?.value ?? getTotalValue()),
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        Text(subTitle, style: TextStyle(fontSize: 18, color: AppColors().grey)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_upward, color: AppColors().green),
            const SizedBox(width: 5),
            Text(Formatting().value(85.35),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
          ],
        ),
      ],
    );
  }
}
