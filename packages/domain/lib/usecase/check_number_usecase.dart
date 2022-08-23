import 'package:domain/models/check_number_params.dart';
import 'usecase.dart';


class CheckNumberUseCase implements UseCaseParams<CheckNumberParams, bool> {
  @override
  bool call(CheckNumberParams params) {
    return params.generatedNumber == params.predictedNumber;
  }
}
