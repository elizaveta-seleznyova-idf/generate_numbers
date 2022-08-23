import 'dart:math';

import 'package:domain/models/check_number_params.dart';
import 'package:domain/usecase/generate_number_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/usecase/check_number_usecase.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final blocCheckUseCase = CheckNumberUseCase();
  final blocGenerateUseCase = GenerateNumberUseCase();
  final Random random = Random();
  final nullingAttempts = 0;

  HomeBloc() : super(const HomeState()) {
    on<GenerateNumberEvent>(_generate);
    on<SubmitNumberEvent>(_submit);
    on<ChangeSubmitButtonStateEvent>(_changeSubmitButton);
  }

  void _generate(
    GenerateNumberEvent event,
    Emitter<HomeState> emit,
  ) {
    final generatedNumber = blocGenerateUseCase.call();
    emit(
      state.copyWith(
        generatedNumber: generatedNumber,
        attempts: nullingAttempts,
        gameState: GameState.inGame,
      ),
    );
  }

  void _submit(
    SubmitNumberEvent event,
    Emitter<HomeState> emit,
  ) {
    if (state.generatedNumber != null) {
      final checkParams = CheckNumberParams(
        state.generatedNumber!,
        event.predictedNumber,
      );
      final isNumberGuessed = blocCheckUseCase.call(checkParams);
      final attempts = state.attempts + 1;
      emit(
        state.copyWith(
          attempts: attempts,
          gameState: isNumberGuessed ? GameState.win : attempts >=3 ? GameState.lose : GameState.inGame,
        ),
      );
    }
  }

  void _changeSubmitButton(
    ChangeSubmitButtonStateEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(isSubmitButtonActive: event.isSubmitButtonActive),
    );
  }
}
