import 'package:domain/models/check_number_params.dart';
import 'package:injectable/injectable.dart';
import 'usecase.dart';

@injectable
class CheckNumberUseCase implements UseCaseParams<CheckNumberParams, bool> {
  static CheckNumberUseCase instance = CheckNumberUseCase();
  @override
  bool call(CheckNumberParams params) {
    return params.generatedNumber == params.predictedNumber;
  }
}
