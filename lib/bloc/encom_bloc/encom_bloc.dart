import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon6/bloc/encom_bloc/encom_event.dart';
import 'package:imtihon6/bloc/encom_bloc/encom_state.dart';
import 'package:imtihon6/data/model/encom.dart';
import 'package:imtihon6/data/service/encom_service.dart';

class EncomBloc extends Bloc<EncomEvent, EncomState> {
  EncomBloc() : super(EncomInitialState()) {
    on<GetEncomsEvent>(_getEncom);
    on<AddEncomEvent>(_onAddEncom);
    on<EditEncomEvent>(_onEditEncom);
    on<DeleteEncomEvent>(_ondeleteEncom);
  }
 

  void _getEncom(GetEncomsEvent event, emit) async {
    emit(EncomLoadingState());
    try {
      final encomService = EncomService();
      List<Encom> encoms = await encomService.get();
      emit(EncomLoadedState(encoms: encoms));
    } catch (error) {
      emit(EncomErrorState(error: error.toString()));
    }
  }

  void _onAddEncom(AddEncomEvent event, emit) async {
    emit(EncomLoadingState());
    try {
      final encomService = EncomService();
      await encomService.insert(
          category: event.category,
          money: event.money,
          description: event.description,
          date: event.date);
      add(GetEncomsEvent());
    } catch (error) {
      emit(EncomErrorState(error: error.toString()));
    }
  }

  void _onEditEncom(EditEncomEvent event, emit) async {
    emit(EncomLoadingState());
    try {
      final encomService = EncomService();
      await encomService.edit(
          encomId: event.id,
          category: event.category,
          money: event.money,
          description: event.description,
          date: event.date);
      add(GetEncomsEvent());
    } catch (error) {
      emit(EncomErrorState(error: error.toString()));
    }
  }

  void _ondeleteEncom(DeleteEncomEvent event, emit) async {
    emit(EncomLoadingState());
    try {
      final encomService = EncomService();
      await encomService.delete(event.id);
      add(GetEncomsEvent());
    } catch (error) {
      emit(EncomErrorState(error: error.toString()));
    }
  }
}
