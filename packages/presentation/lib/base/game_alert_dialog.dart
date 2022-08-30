abstract class DialogEvent {}

class GameAlertDialog implements DialogEvent {
  final String titleText;
  final String contentText;
  final String buttonText;

  GameAlertDialog({
    required this.titleText,
    required this.contentText,
    required this.buttonText,
  });
}
