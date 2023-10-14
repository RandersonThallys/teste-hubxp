// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DataDonutChart {
  final String label;
  final double value;
  final Color? color;
  DataDonutChart({
    required this.label,
    required this.value,
    this.color,
  });
}
