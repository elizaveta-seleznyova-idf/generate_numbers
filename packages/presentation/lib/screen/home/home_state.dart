enum GameState { inGame, lose, win }

class HomeState {
  HomeState({
    this.generatedNumber,
    required this.attempts,
    required this.isSubmitButtonActive,
    required this.gameState,
  });

  int? generatedNumber;
  int attempts;
  bool isSubmitButtonActive;
  GameState gameState;

  factory HomeState.init() => HomeState(
        attempts: 0,
        isSubmitButtonActive: false,
        gameState: GameState.inGame,
      );

  HomeState copy() => HomeState(
      generatedNumber: generatedNumber,
      attempts: attempts,
      isSubmitButtonActive: isSubmitButtonActive,
      gameState: gameState);
}
