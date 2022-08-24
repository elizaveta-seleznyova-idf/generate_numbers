import 'package:domain/usecase/check_number_usecase.dart';
import 'package:domain/usecase/generate_number_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/screen/home/bloc/home_bloc.dart';
import 'package:presentation/screen/home/show_dialog_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        blocCheckUseCase: CheckNumberUseCase.instance,
        blocGenerateUseCase: GenerateNumberUseCase.instance,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Generate',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const HomePage(title: 'Generate numbers'),
      ),
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

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    BlocProvider.of<HomeBloc>(context).add(GenerateNumberEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (_, currentState) {
        return currentState.gameState == GameState.win ||
            currentState.gameState == GameState.lose;
      },
      listener: (context, state) {
        String titleText = '';
        String contentText = '';
        String buttonText = '';

        if (state.gameState == GameState.lose) {
          titleText = 'You lose!';
          contentText = 'The attempts are over. Try again!';
          buttonText = 'Ok :(';
        } else if (state.gameState == GameState.win) {
          titleText = 'You won!';
          contentText = 'The number was : ${state.generatedNumber}';
          buttonText = 'Generate new number';
        }

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return ShowDialogWidget(
                  titleText: titleText,
                  contentText: contentText,
                  buttonText: buttonText,
                  widgetFunction: () {
                    BlocProvider.of<HomeBloc>(context).add(
                      GenerateNumberEvent(),
                    );
                    Navigator.of(context).pop();
                  });
            });
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BlocSelector<HomeBloc, HomeState, int?>(
                  selector: (state) => state.generatedNumber,
                  builder: (context, generatedNumber) {
                    return generatedNumber != null
                        ? Text('Random number: $generatedNumber')
                        : const SizedBox();
                  },
                ),
                const Text(
                  'Try to predict generated number:',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Number?',
                  ),
                  onChanged: (value) {
                    BlocProvider.of<HomeBloc>(context).add(
                      ChangeSubmitButtonStateEvent(
                          isSubmitButtonActive: value.isNotEmpty),
                    );
                  },
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context)
                              .add(GenerateNumberEvent());
                        },
                        child: const Text('Generate')),
                    const SizedBox(
                      width: 15,
                    ),
                    BlocSelector<HomeBloc, HomeState, bool>(
                      selector: (state) => state.isSubmitButtonActive,
                      builder: (context, isSubmitButtonActive) {
                        return ElevatedButton(
                          onPressed: !isSubmitButtonActive
                              ? null
                              : () {
                                  final result = _controller.text;
                                  final int resultSubmit = int.parse(result);
                                  BlocProvider.of<HomeBloc>(context).add(
                                    SubmitNumberEvent(
                                      predictedNumber: resultSubmit,
                                    ),
                                  );
                                },
                          child: const Text('Submit'),
                        );
                      },
                    ),
                  ],
                ),
                BlocSelector<HomeBloc, HomeState, int>(
                  selector: (state) => state.attempts,
                  builder: (context, attempts) {
                    return attempts >= 1
                        ? Text(
                            'Try again. You have ${3 - attempts} more attempts',
                            style: const TextStyle(fontSize: 15),
                          )
                        : const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
