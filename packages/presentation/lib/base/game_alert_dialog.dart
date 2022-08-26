abstract class DialogEvent{}

class GameAlertDialog implements DialogEvent{
  String titleText = '';
  String contentText = '';
  String buttonText = '';
  GameAlertDialog({required this.titleText, required this.contentText, required this.buttonText});
}