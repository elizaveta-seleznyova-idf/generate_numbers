import 'package:domain/usecase/check_number_usecase.dart';
import 'package:domain/usecase/generate_number_usecase.dart';
import 'package:flutter/material.dart';
import 'package:presentation/base/bloc_page.dart';
import 'package:presentation/base/bloc_state.dart';
import 'package:presentation/base/game_alert_dialog.dart';
import 'package:presentation/screen/home/home_bloc.dart';
import 'package:presentation/screen/home/home_state.dart';
import 'package:presentation/screen/home/show_dialog_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Generate',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends BlocScreen {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BlocScreenState<HomePage, HomeBloc> {
  late TextEditingController _controller;

  _HomePageState()
      : super(HomeBloc(
          GenerateNumberUseCase(),
          CheckNumberUseCase(),
        ));

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    bloc.dialogStream.listen(
      (event) {
        if (event is GameAlertDialog) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return ShowDialogWidget(
                  titleText: event.titleText,
                  contentText: event.contentText,
                  buttonText: event.buttonText,
                  widgetFunction: () {
                    bloc.generate();
                    Navigator.of(context).pop();
                  });
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.dataStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          final data = snapshot.data as BlocState;
          final HomeState? blocData = data.data;

          if (blocData == null) {
            return Container();
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Generate numbers'),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    blocData.generatedNumber != null
                        ? Text('Random number: ${blocData.generatedNumber}')
                        : const SizedBox(),
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
                        //value.isNotEmpty ? bloc.submit(int.parse(value)) : null;
                        bloc.changeSubmitButton(value.isNotEmpty);
                      },
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              bloc.generate();
                            },
                            child: const Text('Generate')),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          onPressed: !blocData.isSubmitButtonActive
                              ? null
                              : () {
                                  final result = _controller.text;
                                  final int resultSubmit = int.parse(result);
                                  bloc.submit(resultSubmit);
                                },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                    blocData.attempts >= 1
                        ? Text(
                            'Try again. You have ${3 - blocData.attempts} more attempts',
                            style: const TextStyle(fontSize: 15),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: Text('Something went wrong!'));
        }
      },
    );
  }
}
