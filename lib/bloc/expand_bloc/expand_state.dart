import 'package:imtihon6/data/model/expand.dart';

sealed class ExpandState {}

class ExpandInitialState extends ExpandState {}

class ExpandLoadingState extends ExpandState {}

class ExpandLoadedState extends ExpandState {
  List<Expand> expands;

  ExpandLoadedState({
    required this.expands
  });
}

class ExpandErrorState extends ExpandState {
  final String error;
  ExpandErrorState({required this.error});
}
