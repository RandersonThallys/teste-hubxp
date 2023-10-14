import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class InvestmentModel {
  final String name;
  final double value;
  InvestmentModel({
    required this.name,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
    };
  }

  factory InvestmentModel.fromMap(Map<String, dynamic> map) {
    return InvestmentModel(
      name: map['name'] as String,
      value: map['value'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory InvestmentModel.fromJson(String source) => InvestmentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
