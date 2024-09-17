import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon6/bloc/expand_bloc/expand_state.dart';
import 'package:imtihon6/bloc/expand_bloc/expand_event.dart';
import 'package:imtihon6/data/model/expand.dart';
import 'package:imtihon6/data/service/expand_service.dart';

class ExpandBloc extends Bloc<ExpandEvent, ExpandState> {
  ExpandBloc() : super(ExpandInitialState()) {
    on<GetExpandsEvent>(_getExpand);
    on<AddExpandEvent>(_onAddExpand);
    on<EditExpandEvent>(_onEditExpand);
    on<DeleteExpandEvent>(_ondeleteExpand);
  }

  void _getExpand(GetExpandsEvent event, emit) async {
    emit(ExpandLoadingState());
    try {
      final expandService = ExpandService();
      List<Expand> expands = await expandService.get();
      
      emit(ExpandLoadedState(expands: expands));
    } catch (error) {
      emit(ExpandErrorState(error: error.toString()));
    }
  }

  void _onAddExpand(AddExpandEvent event, emit) async {
    emit(ExpandLoadingState());
    try {
      
      final expandService = ExpandService();
      await expandService.insert(
          category: event.category,
          money: event.money,
          description: event.description,
          date: event.date);
      add(GetExpandsEvent());
    } catch (error) {
      emit(ExpandErrorState(error: error.toString()));
    }
  }

  void _onEditExpand(EditExpandEvent event, emit) async {
    emit(ExpandLoadingState());
    try {
      final expandService = ExpandService();
      await expandService.edit(
          expandId: event.id,
          category: event.category,
          money: event.money,
          description: event.description,
          date: event.date);
      add(GetExpandsEvent());
    } catch (error) {
      emit(ExpandErrorState(error: error.toString()));
    }
  }

  void _ondeleteExpand(DeleteExpandEvent event, emit) async {
    emit(ExpandLoadingState());
    try {
      final expandService = ExpandService();
      await expandService.delete(event.id);
      add(GetExpandsEvent());
    } catch (error) {
      emit(ExpandErrorState(error: error.toString()));
    }
  }
}
