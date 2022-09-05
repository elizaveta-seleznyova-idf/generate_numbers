import 'package:domain/usecase/check_number_usecase.dart';
import 'package:domain/usecase/generate_number_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/screen/home/home_bloc.dart';
import 'package:presentation/screen/home/home_dialog_mapper.dart';

void initPresentationInjector() {
  _initDialogMapperModule();
  _initBlocModule();
}

void _initDialogMapperModule() {
  GetIt.I.registerFactory<HomeDialogMapper>(
    () => HomeDialogMapper(),
  );
}

void _initBlocModule() {
  GetIt.I.registerFactory<HomeBloc>(
    () => HomeBloc(
      GetIt.I.get<GenerateNumberUseCase>(),
      GetIt.I.get<CheckNumberUseCase>(),
      GetIt.I.get<HomeDialogMapper>(),
    ),
  );
}
