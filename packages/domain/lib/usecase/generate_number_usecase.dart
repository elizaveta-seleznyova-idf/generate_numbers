import 'dart:math';
import 'usecase.dart';

class GenerateNumberUseCase implements UseCase<int>{
  final Random random = Random();
  @override
  int call() {
    return random.nextInt(9);
  }
}