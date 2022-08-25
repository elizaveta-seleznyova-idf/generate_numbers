import 'package:flutter/material.dart';
import 'package:presentation/base/bloc.dart';

abstract class BlocScreen extends StatefulWidget {
  const BlocScreen({Key? key}) : super(key: key);
}

abstract class BlocScreenState <BS extends BlocScreen, B extends Bloc> extends State<BS>  {
  BlocScreenState(this.bloc);
  @protected
  final B bloc;

  @override
  void initState() {
    super.initState();
    bloc.initState();
  }
}
