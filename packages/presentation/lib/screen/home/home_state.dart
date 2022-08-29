enum GameState { inGame, lose, win }

class HomeState {

  HomeState({
    this.generatedNumber,
    this.predictedNumber,
    required this.attempts,
    required this.isSubmitButtonActive,
    required this.gameState,
  });

  final int? predictedNumber;
  final int? generatedNumber;
  final int attempts;
  final bool isSubmitButtonActive;
  final GameState gameState;

  factory HomeState.init() => HomeState(
        attempts: 0,
        isSubmitButtonActive: false,
        gameState: GameState.inGame,
      );

  HomeState copy() => HomeState(
        generatedNumber: generatedNumber,
        predictedNumber: predictedNumber,
        attempts: attempts,
        isSubmitButtonActive: isSubmitButtonActive,
        gameState: gameState,
      );

  HomeState copyWith({
    int? generatedNumber,
    int? predictedNumber,
    int? attempts,
    bool? isSubmitButtonActive,
    GameState? gameState,
  }) =>
      HomeState(
        generatedNumber: generatedNumber ?? this.generatedNumber,
        predictedNumber:  predictedNumber ?? this.predictedNumber,
        attempts: attempts ?? this.attempts,
        isSubmitButtonActive: isSubmitButtonActive ?? this.isSubmitButtonActive,
        gameState: gameState ?? this.gameState,
      );
}
