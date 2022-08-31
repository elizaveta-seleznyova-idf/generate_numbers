import 'package:flutter/material.dart';
import 'package:generate_numbers/di/app_injector.dart';
import 'package:presentation/screen/generate_numbers_app.dart';

void main() {
  initAppInjector();
  runApp(const GenerateNumbersApp());
}
