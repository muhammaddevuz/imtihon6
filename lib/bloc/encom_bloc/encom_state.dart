import 'package:imtihon6/data/model/encom.dart';

sealed class EncomState {}

class EncomInitialState extends EncomState {}

class EncomLoadingState extends EncomState {}

class EncomLoadedState extends EncomState {
  List<Encom> encoms;
  EncomLoadedState({
    required this.encoms
  });
}

class EncomErrorState extends EncomState {
  final String error;
  EncomErrorState({required this.error});
}
