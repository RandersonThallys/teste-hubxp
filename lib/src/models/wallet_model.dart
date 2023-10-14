// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'investment_model.dart';

class WalletModel {
  final double totalAssets;
  final double profitability;
  List<InvestmentModel> investments;
  WalletModel({
    required this.totalAssets,
    required this.profitability,
    required this.investments,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalAssets': totalAssets,
      'profitability': profitability,
      'investments': investments.map((x) => x.toMap()).toList(),
    };
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      totalAssets: map['totalAssets'] as double,
      profitability: map['profitability'] as double,
      investments: List<InvestmentModel>.from((map['investments']).map<InvestmentModel>((x) => InvestmentModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletModel.fromJson(String source) => WalletModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
