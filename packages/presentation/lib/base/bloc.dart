import 'dart:async';
import 'package:flutter/material.dart';
import 'package:presentation/base/game_alert_dialog.dart';
import 'package:presentation/base/bloc_state.dart';

abstract class Bloc{
  Stream<BlocState> get dataStream;
  Stream<DialogEvent> get dialogStream;

  void initState();
}

abstract class BlocImpl implements Bloc {
  final _data = StreamController<BlocState>();
  final _dialog = StreamController<DialogEvent>();
  final _blocState = BlocState.init();

  @override
  Stream<BlocState> get dataStream => _data.stream;

  @override
  Stream<DialogEvent> get dialogStream => _dialog.stream;

  @protected
  void handleData({dynamic data}){
    _blocState.updateParams(data);
    _data.add(_blocState.copy());
  }

  @protected
  void showDialog({required DialogEvent event}){
    _dialog.add(event);
  }

  @override
  void initState() {}
}