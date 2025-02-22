import 'package:flutter_bloc/flutter_bloc.dart';

import '../../db/db_helper.dart';
import 'crud_event.dart';
import 'crud_state.dart';

class CrudBloc extends Bloc<CrudEvent, CrudState> {
  final dbHelper = DbHelper();

  CrudBloc() : super(CrudInitialState()) {
    on<CrudAddEvent>(
      (event, emit) async {
        await dbHelper.insertData(event.name);
        await loadListData(emit);
      },
    );
    on<CrudLoadEvent>(
      (event, emit) async {
        await loadListData(emit);
      },
    );
    on<CrudDeleteByNameEvent>(
      (event, emit) async {
        await dbHelper.deleteData(event.id);
        await loadListData(emit);
      },
    );

    on<CrudEditClickEvent>(
      (event, emit) {
        emit(CrudUpdateState(
            isEditable: true,
            id: event.id,
            name: event.name,
            list: (state as CrudUpdateState).list));
      },
    );

    on<CrudUpdateTextEvent>(
      (event, emit) async {
        await dbHelper.updateData((state as CrudUpdateState).id, event.name);
        await loadListData(emit);
      },
    );
  }

  Future<void> loadListData(Emitter<CrudState> emit) async {
    List<Map<String, Object?>>? li = await dbHelper.getAllData();
    emit(CrudUpdateState(list: li));
  }
}
