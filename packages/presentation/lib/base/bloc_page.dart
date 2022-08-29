import 'package:flutter/material.dart';
import 'package:presentation/base/bloc.dart';

abstract class BlocScreenState <BS extends StatefulWidget, B extends Bloc> extends State<BS>  {
  BlocScreenState(this.bloc);
  @protected
  final B bloc;

  @override
  void initState() {
    super.initState();
    bloc.initState();
  }
}
