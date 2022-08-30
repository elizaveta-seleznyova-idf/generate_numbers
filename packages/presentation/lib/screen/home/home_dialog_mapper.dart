import 'package:presentation/screen/data/DialogParams.dart';
import 'package:presentation/screen/home/home_state.dart';

abstract class HomeDialogMapper {
  factory HomeDialogMapper() => _HomeDialogMapper();

  DialogParams? mapDialogParams(HomeState state);
}

class _HomeDialogMapper implements HomeDialogMapper {
  @override
  DialogParams? mapDialogParams(HomeState state) {
    final DialogParams? params;
    if (state.gameState == GameState.lose) {
      params = DialogParams(
        titleText: 'You lose!',
        contentText: 'The attempts are over. Try again!',
        buttonText: 'Ok :(',
      );
    } else if (state.gameState == GameState.win) {
      params = DialogParams(
        titleText: 'You won!',
        contentText: 'The number was : ${state.generatedNumber}',
        buttonText: 'Generate new number',
      );
    } else {
      params = null;
    }
    return params;
  }
}
