import 'dart:math';
import 'package:injectable/injectable.dart';

import 'usecase.dart';

@injectable
class GenerateNumberUseCase implements UseCase<int>{
  static GenerateNumberUseCase instance = GenerateNumberUseCase();
  final Random random = Random();
  final maxGenerateNumber = 9;
  @override
  int call() {
    return random.nextInt(maxGenerateNumber);
  }
}