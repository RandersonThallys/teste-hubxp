// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:teste_hub/src/models/profitability_rate_model.dart';
import 'package:teste_hub/src/models/wallet_model.dart';
import 'package:teste_hub/src/repositories/wallet_repository.dart';
import 'package:teste_hub/src/models/data_donut_chart.dart';

class HomeStore {
  final WalletRepository repository;
  HomeStore({
    required this.repository,
  });

  late ValueNotifier<WalletModel> wallet = ValueNotifier(
      WalletModel(totalAssets: 0, profitability: 0, investments: []));

  late ValueNotifier<List<ProfitabilityRateModel>> profitabilityRates =
      ValueNotifier([]);

  late ValueNotifier<DataDonutChart?> selectedDonutChart = ValueNotifier(null);

  List<ProfitabilityRateModel> get profitabilityRatesValue =>
      profitabilityRates.value;
  fetchWallet() {
    wallet.value = repository.getWallet();
  }

  fetchgetProfitabilityRate(TimeFilter filter) {
    profitabilityRates.value = repository.getProfitabilityRate(filter: filter);
  }

  setSelectedDonutChart(DataDonutChart? value){
    selectedDonutChart.value = value;
  }

  
}
