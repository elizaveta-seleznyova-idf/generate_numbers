import 'dart:math';

import 'package:domain/models/check_number_params.dart';
import 'package:domain/usecase/check_number_usecase.dart';
import 'package:domain/usecase/generate_number_usecase.dart';
import 'package:presentation/base/game_alert_dialog.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/screen/home/home_state.dart';

abstract class HomeBloc extends Bloc {
  factory HomeBloc(GenerateNumberUseCase generateNumberUseCase,
          CheckNumberUseCase checkNumberUseCase) =>
      HomeBlocImpl(generateNumberUseCase, checkNumberUseCase);

  void generate();

  void submit(int predictedNumber);

  void changeSubmitButton(bool isSubmitButtonActive);
}

class HomeBlocImpl extends BlocImpl implements HomeBloc {
  final _state = HomeState.init();
  final GenerateNumberUseCase blocGenerateUseCase;
  final CheckNumberUseCase blocCheckUseCase;
  final Random random = Random();
  final nullingAttempts = 0;
  final maxAttempts = 3;

  HomeBlocImpl(this.blocGenerateUseCase, this.blocCheckUseCase);

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
    required String buttonText,
    required String titleText,
    required String contentText,
  }) {
    showDialog(
      event: GameAlertDialog(
        buttonText: buttonText,
        titleText: titleText,
        contentText: contentText,
      ),
    );
  }

  @override
  void generate() {
    final generatedNumber = blocGenerateUseCase.call();
    _state.generatedNumber = generatedNumber;
    _state.attempts = nullingAttempts;
    _state.gameState = GameState.inGame;
    _updateData(
      data: _state,
    );
  }

  @override
  void submit(int predictedNumber) {
    if (_state.generatedNumber != null) {
      final checkParams = CheckNumberParams(
        _state.generatedNumber!,
        predictedNumber,
      );
      final isNumberGuessed = blocCheckUseCase.call(checkParams);
      final attempts = _state.attempts + 1;
      final checkAttempts =
          attempts >= maxAttempts ? GameState.lose : GameState.inGame;
      final gameState = isNumberGuessed ? GameState.win : checkAttempts;

      if (gameState == GameState.lose) {
        const String blocTitleText = 'You lose!';
        const String blocContentText = 'The attempts are over. Try again!';
        const String blocButtonText = 'Ok :(';
        _showDialog(
          buttonText: blocButtonText,
          titleText: blocTitleText,
          contentText: blocContentText,
        );
      } else if (gameState == GameState.win) {
        const String blocTitleText = 'You won!';
        final String blocContentText = 'The number was : ${_state.generatedNumber}';
        const String blocButtonText ='Generate new number';
        _showDialog(
          buttonText: blocButtonText,
          titleText: blocTitleText,
          contentText: blocContentText,
        );
      }
      _state.attempts = attempts;
      _state.gameState = gameState;
      _updateData(
        data: _state,
      );
    }
  }

  @override
  void changeSubmitButton(bool isSubmitButtonActive) {
    _state.isSubmitButtonActive = isSubmitButtonActive;
    _updateData(
      data: _state,
    );
  }
}
