abstract class CrudEvent {}

class CrudAddEvent extends CrudEvent {
  String name;

  CrudAddEvent({required this.name});
}

class CrudLoadEvent extends CrudEvent {
  CrudLoadEvent();
}

class CrudDeleteByNameEvent extends CrudEvent {
  int id;

  CrudDeleteByNameEvent({required this.id});
}

class CrudEditClickEvent extends CrudEvent {
  int id;
  String name;

  CrudEditClickEvent({required this.id, required this.name});
}

class CrudUpdateTextEvent extends CrudEvent {
  int id;
  String name;

  CrudUpdateTextEvent({required this.id, required this.name});
}
