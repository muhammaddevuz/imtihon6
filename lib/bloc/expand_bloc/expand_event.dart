sealed class ExpandEvent {}

class GetExpandsEvent extends ExpandEvent {}

class AddExpandEvent extends ExpandEvent {
  double money;
  String category;
  DateTime date;
  String description;

  AddExpandEvent({
    required this.money,
    required this.category,
    required this.date,
    required this.description,
  });
}

class EditExpandEvent extends ExpandEvent {
  int id;
  double money;
  String category;
  DateTime date;
  String description;

  EditExpandEvent({
    required this.id,
    required this.money,
    required this.category,
    required this.date,
    required this.description,
  });
}

class DeleteExpandEvent extends ExpandEvent {
  int id;

  DeleteExpandEvent({required this.id});
}
