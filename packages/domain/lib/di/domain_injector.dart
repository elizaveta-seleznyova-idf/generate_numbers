import 'package:domain/usecase/check_number_usecase.dart';
import 'package:domain/usecase/generate_number_usecase.dart';
import 'package:get_it/get_it.dart';

void initDomainInjector() {
  _initUseCaseModule();
}

void _initUseCaseModule() {
  GetIt.I.registerFactory<GenerateNumberUseCase>(
    () => GenerateNumberUseCase(),
  );
  GetIt.I.registerFactory<CheckNumberUseCase>(
    () => CheckNumberUseCase(),
  );
}
