import 'package:flutter/material.dart';
import 'package:generate_numbers/di/app_injector.dart';
import 'package:presentation/screen/home/home_page.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}
