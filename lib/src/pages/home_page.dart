import 'package:flutter/material.dart';
import 'package:teste_hub/src/core/theme/colors.dart';
import 'package:teste_hub/src/core/utils/formatting.dart';
import 'package:teste_hub/src/pages/home_store.dart';
import 'package:teste_hub/src/repositories/wallet_repository.dart';
import 'package:teste_hub/src/models/data_donut_chart.dart';
import 'package:teste_hub/src/widgets/donut_chart/donut_chart_widget.dart';
import 'package:teste_hub/src/widgets/line_chart/data_line_chart.dart';
import 'package:teste_hub/src/widgets/line_chart/line_chart_widget.dart';
import 'package:teste_hub/src/widgets/line_chart/time_filter_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = HomeStore(repository: WalletRepository());
  List<bool> filterSelect = [true, false, false];
  bool filterClicked = false;

  @override
  void initState() {
    store.fetchWallet();
    store.fetchgetProfitabilityRate(TimeFilter.year);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: () {
          store.setSelectedDonutChart(null);
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Donut Chart:',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).width,
                    child: DonutChartWidget(
                        title: 'Total do patrimônio',
                        subTitle: 'Rentabilidade',
                        store: store,
                        data: store.wallet.value.investments
                            .map((investment) => DataDonutChart(
                                label: investment.name,
                                value: investment.value))
                            .toList()),
                  ),
                ),
                const Text(
                  'Line Chart:',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Posição",
                          style: TextStyle(
                              fontSize: 22, color: AppColors().grey2)),
                      Text(Formatting().value(5987.37),
                          style: TextStyle(
                              fontSize: 26,
                              color: AppColors().darkIndigo,
                              fontWeight: FontWeight.w800)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Rentabilidade",
                              style: TextStyle(
                                  fontSize: 20, color: AppColors().grey2)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(Icons.arrow_upward,
                                color: AppColors().green),
                          ),
                          Text(
                              "${Formatting().value(85.35)} | ${Formatting().value(8.64)}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors().green))
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                ),
                if (store.profitabilityRatesValue.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: SizedBox(
                        height: MediaQuery.sizeOf(context).width,
                        width: MediaQuery.sizeOf(context).width,
                        child: ValueListenableBuilder(
                            valueListenable: store.profitabilityRates,
                            builder: (context, profitabilityRates, _) {
                              return LineChartWidget(
                                filterClicked: filterClicked,
                                data: profitabilityRates
                                    .map((profitabilityRate) => DataLineChart(
                                        label: profitabilityRate.rateName,
                                        spots: profitabilityRate.rates.indexed
                                            .map((e) => (e.$1.toDouble(), e.$2))
                                            .toList()))
                                    .toList(),
                                timeFilter: [
                                  TimeFilterWidget(
                                      label: '2023',
                                      onPressed: (value) {
                                        setState(() {
                                          filterClicked = true;
                                          store.fetchgetProfitabilityRate(
                                              TimeFilter.year);
                                          filterSelect = [true, false, false];
                                        });

                                        Future.delayed(const Duration(seconds: 1)).then((value) {
                                         setState(() {
                                           filterClicked = false;
                                         });
                                        });
                                      },
                                      selected: filterSelect[0]),
                                  TimeFilterWidget(
                                      label: '3M',
                                      onPressed: (value) {
                                        setState(() {
                                          filterClicked = true;
                                          store.fetchgetProfitabilityRate(
                                              TimeFilter.threeMonth);
                                          filterSelect = [false, true, false];
                                        });

                                        Future.delayed(const Duration(seconds: 1)).then((value) {
                                          setState(() {
                                            filterClicked = false;
                                          });
                                        });
                                      },
                                      selected: filterSelect[1]),
                                  TimeFilterWidget(
                                      label: '6M',
                                      onPressed: (value) {
                                        setState(() {
                                          filterClicked = true;
                                          store.fetchgetProfitabilityRate(
                                              TimeFilter.sixMonth);
                                          filterSelect = [false, false, true];
                                        });

                                        Future.delayed(const Duration(seconds: 1)).then((value) {
                                          setState(() {
                                            filterClicked = false;
                                          });
                                        });
                                      },
                                      selected: filterSelect[2])
                                ],
                              );
                            })),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
