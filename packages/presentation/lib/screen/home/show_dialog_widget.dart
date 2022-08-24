import 'package:flutter/material.dart';

class ShowDialogWidget extends StatelessWidget {
  final String titleText;
  final String contentText;
  final String buttonText;
  final Function widgetFunction;

  const ShowDialogWidget(
      {super.key,
      required this.titleText,
      required this.contentText,
      required this.buttonText,
      required this.widgetFunction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleText),
      content: Text(contentText),
      actions: <Widget>[
        TextButton(
          child: Text(buttonText),
          onPressed: () {
            widgetFunction();
          },
        )
      ],
    );
  }
}
