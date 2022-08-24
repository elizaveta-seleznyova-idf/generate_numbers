part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable{}

class GenerateNumberEvent extends HomeEvent{
  @override
  List<Object?> get props => [];
}

class SubmitNumberEvent extends HomeEvent{
  final int predictedNumber;

  SubmitNumberEvent({required this.predictedNumber});

  @override
  List<Object?> get props => [predictedNumber];
}

class ChangeSubmitButtonStateEvent extends HomeEvent {
  final bool isSubmitButtonActive;

  ChangeSubmitButtonStateEvent({required this.isSubmitButtonActive});

  @override
  List<Object> get props => [isSubmitButtonActive];
}