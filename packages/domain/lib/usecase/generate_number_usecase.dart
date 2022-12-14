import 'dart:math';
import 'usecase.dart';

class GenerateNumberUseCase implements UseCase<int>{
  static GenerateNumberUseCase instance = GenerateNumberUseCase();
  final Random random = Random();
  final maxGenerateNumber = 9;
  @override
  int call() {
    return random.nextInt(maxGenerateNumber);
  }
}