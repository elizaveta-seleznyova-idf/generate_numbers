part of 'home_bloc.dart';

enum GameState { inGame, lose, win }

class HomeState extends Equatable {
  final int? generatedNumber;
  final int attempts;
  final bool isSubmitButtonActive;
  final GameState gameState;

  const HomeState({
    this.gameState = GameState.inGame,
    this.generatedNumber,
    this.attempts = 0,
    this.isSubmitButtonActive = false,
  });

  @override
  String toString() {
    return 'HomeState{generatedNumber: $generatedNumber, attempts: $attempts, isSubmitButtonActive: $isSubmitButtonActive, gameState: $gameState}';
  }

  HomeState copyWith({
    int? generatedNumber,
    int? attempts,
    bool? isSubmitButtonActive,
    GameState? gameState,
  }) {
    return HomeState(
      generatedNumber: generatedNumber ?? this.generatedNumber,
      attempts: attempts ?? this.attempts,
      isSubmitButtonActive: isSubmitButtonActive ?? this.isSubmitButtonActive,
      gameState: gameState ?? this.gameState,
    );
  }

  @override
  List<Object?> get props =>
      [generatedNumber, attempts, isSubmitButtonActive, gameState];
}
