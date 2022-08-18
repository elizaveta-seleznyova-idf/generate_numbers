import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Generate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Generate numbers'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _controller;
  String _result = '';
  final String _message = 'Your predicted number :';
  final bool shouldDisplay = false;
  final Random random = Random();
  String? randomNumber;
  int attempts = 0;
  bool _active = false;

  void generateNumber() {
    setState(() {
      randomNumber = random.nextInt(9).toString();
      attempts = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => generateNumber());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Predited number: $randomNumber'),
              const Text(
                'Try to predict generated number:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number?',
                ),
                onChanged: (value) {
                  setState(() {
                    _active = value.length == 1 ? true : false;
                  });
                },
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        generateNumber();
                      },
                      child: const Text('Generate')),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: _active== true ? _buttonActivity : null,
                    child: const Text('Submit'),
                  ),
                ],
              ),
              Text(
                attempts >= 1 ? '$_message $_result' : '',
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _buttonActivity() {
    attempts++;
    print(attempts);
    if (attempts >= 3) {
      attempts = 0;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('You lose!'),
            // Retrieve the text which the user has entered by
            // using the TextEditingController.
            content: const Text('The attempts are over. Try again!'),
            actions: <Widget>[
              TextButton(
                child: const  Text('Ok :('),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    } else if (attempts < 3) {
      _result = _controller.text;
      (_result == randomNumber)
          ? showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('You won'),
                  content: Text(_controller.text),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Generate new number'),
                      onPressed: () {
                        generateNumber();
                        Navigator.of(context).pop();
                        _result = '';
                      },
                    )
                  ],
                );
              },
            )
          : setState(() {
              _result = _controller.text;
            });
    }
  }
}
