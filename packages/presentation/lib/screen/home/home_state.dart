enum GameState { inGame, lose, win }

class HomeState {
  HomeState({
    this.generatedNumber,
    this.predictedNumber,
    required this.isAttemptsTextAvailable,
    required this.attempts,
    required this.isSubmitButtonActive,
    required this.gameState,
  });

  final int? predictedNumber;
  final int? generatedNumber;
  final int attempts;
  final bool isAttemptsTextAvailable;
  final bool isSubmitButtonActive;
  final GameState gameState;

  factory HomeState.init() => HomeState(
        attempts: 0,
        isSubmitButtonActive: false,
        gameState: GameState.inGame,
        isAttemptsTextAvailable: false,
      );

  HomeState copy() => HomeState(
        generatedNumber: generatedNumber,
        predictedNumber: predictedNumber,
        attempts: attempts,
        isAttemptsTextAvailable: isAttemptsTextAvailable,
        isSubmitButtonActive: isSubmitButtonActive,
        gameState: gameState,
      );

  HomeState copyWith({
    int? generatedNumber,
    int? predictedNumber,
    int? attempts,
    bool? isAttemptsTextAvailable,
    bool? isSubmitButtonActive,
    GameState? gameState,
  }) =>
      HomeState(
        generatedNumber: generatedNumber ?? this.generatedNumber,
        predictedNumber: predictedNumber ?? this.predictedNumber,
        attempts: attempts ?? this.attempts,
        isAttemptsTextAvailable:
            isAttemptsTextAvailable ?? this.isAttemptsTextAvailable,
        isSubmitButtonActive: isSubmitButtonActive ?? this.isSubmitButtonActive,
        gameState: gameState ?? this.gameState,
      );
}
