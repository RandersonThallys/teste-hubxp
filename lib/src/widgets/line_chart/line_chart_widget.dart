// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:teste_hub/src/core/theme/colors.dart';

import 'package:teste_hub/src/widgets/line_chart/data_line_chart.dart';
import 'package:teste_hub/src/widgets/line_chart/time_filter_widget.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({
    Key? key,
    required this.data,
    required this.timeFilter,
    required this.filterClicked,
  }) : super(key: key);
  final List<DataLineChart> data;
  final List<TimeFilterWidget> timeFilter;
  final bool filterClicked;

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  late DataLineChart defaultData;
  late List<DataLineChart> _data;
  late DataLineChart selectedData;
  @override
  void initState() {
    defaultData = widget.data.first;
    _data = widget.data.sublist(1);
    selectedData = _data.first;
    super.initState();
  }

  TextStyle textStyle = TextStyle(fontSize: 16, color: AppColors().grey2);

  @override
  Widget build(BuildContext context) {
    if (widget.filterClicked){
      defaultData = widget.data.first;
      _data = widget.data.sublist(1);
      selectedData = _data.first;
    }

    return Column(
      children: [
        Row(
          children: [
            Container(
              color: AppColors().darkIndigo,
              margin: const EdgeInsets.only(right: 10),
              height: MediaQuery.sizeOf(context).width * 0.03,
              width: MediaQuery.sizeOf(context).width * 0.07,
            ),
            Text(
              defaultData.label,
              style: textStyle,
            ),
            const Spacer(),
            Container(
              color: AppColors().amber,
              margin: const EdgeInsets.only(right: 10),
              height: MediaQuery.sizeOf(context).width * 0.03,
              width: MediaQuery.sizeOf(context).width * 0.07,
            ),
            DropdownButton(
                value: selectedData,
                icon: const Icon(Icons.keyboard_arrow_down),
                style: textStyle,
                items: _data
                    .map((rate) => DropdownMenuItem<DataLineChart>(
                        value: rate,
                        child: Text(
                          rate.label,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        )))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedData = value;
                    });
                  }
                })
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("90,05 do CDI", style: textStyle),
              Text("100% do CDI", style: textStyle),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).width * 0.6,
          width: MediaQuery.sizeOf(context).width,
          child: LineChart(
            LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 2,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.shade300,
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey.shade300,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: const FlTitlesData(
                  show: false,
                ),
                borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.grey.shade300,
                    )),
                lineBarsData: [
                  LineChartBarData(
                      color: AppColors().darkIndigo,
                      barWidth: 3,
                      spots: defaultData.spots
                          .map((e) => FlSpot(e.$1, e.$2))
                          .toList()),
                  if (_data.isNotEmpty)
                    LineChartBarData(
                        color: AppColors().amber,
                        barWidth: 3,
                        spots: selectedData.spots
                            .map((e) => FlSpot(e.$1, e.$2))
                            .toList())
                ]),
          ),
        ),
        Row(
          children: widget.timeFilter
              .map((e) => Padding(
                    padding: const EdgeInsets.only(top: 16, right: 16),
                    child: e,
                  ))
              .toList(),
        )
      ],
    );
  }
}
