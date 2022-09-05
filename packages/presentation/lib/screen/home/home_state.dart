enum GameState { inGame, lose, win }

class HomeState {
  HomeState({
    this.generatedNumber,
    this.predictedNumber,
    this.leftAttempts,
    required this.isAttemptsTextAvailable,
    required this.attempts,
    required this.isSubmitButtonActive,
    required this.gameState,
  });

  final int? predictedNumber;
  final int? generatedNumber;
  final int attempts;
  final int? leftAttempts;
  final bool isAttemptsTextAvailable;
  final bool isSubmitButtonActive;
  final GameState gameState;

  factory HomeState.init() => HomeState(
        attempts: 0,
        isSubmitButtonActive: false,
        gameState: GameState.inGame,
        isAttemptsTextAvailable: false,
      );


  HomeState copyWith({
    int? generatedNumber,
    int? predictedNumber,
    int? attempts,
    int? leftAttempts,
    bool? isAttemptsTextAvailable,
    bool? isSubmitButtonActive,
    GameState? gameState,
  }) =>
      HomeState(
        generatedNumber: generatedNumber ?? this.generatedNumber,
        predictedNumber: predictedNumber ?? this.predictedNumber,
        leftAttempts: leftAttempts ?? this.leftAttempts,
        attempts: attempts ?? this.attempts,
        isAttemptsTextAvailable:
            isAttemptsTextAvailable ?? this.isAttemptsTextAvailable,
        isSubmitButtonActive: isSubmitButtonActive ?? this.isSubmitButtonActive,
        gameState: gameState ?? this.gameState,
      );
}
