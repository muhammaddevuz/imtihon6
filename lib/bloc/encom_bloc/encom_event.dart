sealed class EncomEvent {}

class GetEncomsEvent extends EncomEvent {}

class AddEncomEvent extends EncomEvent {
  double money;
  String category;
  DateTime date;
  String description;

  AddEncomEvent({
    required this.money,
    required this.category,
    required this.date,
    required this.description,
  });
}

class EditEncomEvent extends EncomEvent {
  int id;
  double money;
  String category;
  DateTime date;
  String description;

  EditEncomEvent({
    required this.id,
    required this.money,
    required this.category,
    required this.date,
    required this.description,
  });
}

class DeleteEncomEvent extends EncomEvent {
  int id;

  DeleteEncomEvent({required this.id});
}
