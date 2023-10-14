import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfitabilityRateModel {
  final String rateName;
  final List<double> rates;
  ProfitabilityRateModel({
    required this.rateName,
    required this.rates,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rateName': rateName,
      'rates': rates,
    };
  }

  factory ProfitabilityRateModel.fromMap(Map<String, dynamic> map) {
    return ProfitabilityRateModel(
        rateName: map['rateName'] as String,
        rates: List<double>.from(
          (map['rates']),
        ));
  }

  String toJson() => json.encode(toMap());

  factory ProfitabilityRateModel.fromJson(String source) =>
      ProfitabilityRateModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
