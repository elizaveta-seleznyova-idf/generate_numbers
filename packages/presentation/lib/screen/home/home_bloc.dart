import 'dart:math';

import 'package:domain/models/check_number_params.dart';
import 'package:domain/usecase/check_number_usecase.dart';
import 'package:domain/usecase/generate_number_usecase.dart';
import 'package:presentation/base/game_alert_dialog.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/screen/data/DialogParams.dart';
import 'package:presentation/screen/home/home_dialog_mapper.dart';
import 'package:presentation/screen/home/home_state.dart';

abstract class HomeBloc extends Bloc {
  factory HomeBloc(
    GenerateNumberUseCase generateNumberUseCase,
    CheckNumberUseCase checkNumberUseCase,
    HomeDialogMapper dialogMapper,
  ) =>
      HomeBlocImpl(
        generateNumberUseCase,
        checkNumberUseCase,
        dialogMapper,
      );

  void generate();

  void submit();

  void changeSubmitButton(bool isSubmitButtonActive);

  void setNumber(String text);
}

class HomeBlocImpl extends BlocImpl implements HomeBloc {
  var _state = HomeState.init();
  final GenerateNumberUseCase blocGenerateUseCase;
  final CheckNumberUseCase blocCheckUseCase;
  final Random random = Random();
  final nullingAttempts = 0;
  final maxAttempts = 3;
  final HomeDialogMapper _dialogMapper;

  HomeBlocImpl(
    this.blocGenerateUseCase,
    this.blocCheckUseCase,
    this._dialogMapper,
  );

  @override
  void initState() {
    super.initState();
    _updateData(data: _state);
    generate();
  }

  _updateData({HomeState? data}) {
    handleData(
      data: data,
    );
  }

  _showDialog({
    required DialogParams params,
  }) {
    showDialog(
      event: GameAlertDialog(
        buttonText: params.buttonText,
        titleText: params.titleText,
        contentText: params.contentText,
      ),
    );
  }

  @override
  void generate() {
    final generatedNumber = blocGenerateUseCase();
    _state = _state.copyWith(
      generatedNumber: generatedNumber,
      attempts: nullingAttempts,
      gameState: GameState.inGame,
    );
    _updateData(
      data: _state,
    );
  }

  @override
  void submit() {
    final generatedNumber = _state.generatedNumber;
    if (generatedNumber != null) {
      final checkParams = CheckNumberParams(
        generatedNumber,
        _state.predictedNumber ?? 0,
      );
      final isNumberGuessed = blocCheckUseCase(checkParams);
      final attempts = _state.attempts + 1;
      final checkAttempts =
          attempts >= maxAttempts ? GameState.lose : GameState.inGame;
      final gameState = isNumberGuessed ? GameState.win : checkAttempts;
      _state = _state.copyWith(
        attempts: attempts,
        gameState: gameState,
      );
      _updateData(
        data: _state,
      );
      _showResultDialog(gameState: gameState);
    }
  }

  void _showResultDialog({required GameState gameState}) {
    DialogParams? params = _dialogMapper.mapDialogParams(_state);

    if (params != null) {
      _showDialog(params: params);
    }
  }

  @override
  void changeSubmitButton(bool isSubmitButtonActive) {
    _state = _state.copyWith(isSubmitButtonActive: isSubmitButtonActive);
    _updateData(
      data: _state,
    );
  }

  @override
  void setNumber(String text) {
    _state = _state.copyWith(
      predictedNumber: int.tryParse(text),
    );
  }
}
