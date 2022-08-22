import 'usecase.dart';

class CheckNumberParams {
  final int generatedNumber;
  final int predictedNumber;

  CheckNumberParams(this.generatedNumber, this.predictedNumber);
}

class CheckNumberUseCase implements UseCaseParams<CheckNumberParams, bool> {
  @override
  bool call(CheckNumberParams params) {
    return params.generatedNumber == params.predictedNumber;
  }
}
