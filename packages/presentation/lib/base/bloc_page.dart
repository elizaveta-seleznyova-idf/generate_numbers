import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/base/bloc.dart';

abstract class BlocScreenState<BS extends StatefulWidget, B extends Bloc>
    extends State<BS> {
  @protected
  final B bloc = GetIt.I.get<B>();

  @override
  void initState() {
    super.initState();
    bloc.initState();
  }
}
