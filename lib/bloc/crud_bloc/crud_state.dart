

abstract class CrudState {}

class CrudInitialState extends CrudState {
  CrudInitialState();
}

class CrudUpdateState extends CrudState {
  int id;
  String name;
  bool isEditable;
  List<Map<String, Object?>>? list;

  CrudUpdateState(
      {this.id = 0,
      this.name = '',
      required this.list,
      this.isEditable = false});
}
