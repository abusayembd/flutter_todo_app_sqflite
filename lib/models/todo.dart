class Todo {

  String title;
  String description;
  String category;
  String todoDate;
  int isFinished;

  Todo({

    required this.title,
    required this.description,
    required this.category,
    required this.todoDate,
    required this.isFinished,
  });

  todoMap() {
    var mapping = <String, dynamic>{};
    mapping['title'] = title;
    mapping['description'] = description;
    mapping['category'] = category;
    mapping['todoDate'] = todoDate;
    mapping['isFinished'] = isFinished;
    return mapping;
  }
}
