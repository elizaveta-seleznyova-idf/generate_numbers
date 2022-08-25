abstract class DialogEvent{}

class GameAlertDialog implements DialogEvent{
  String titleText = 'Проверка 1';
  String contentText = 'Проверка 2';
  String buttonText = 'Проверка 3';
  GameAlertDialog({required this.titleText, required this.contentText, required this.buttonText});
}