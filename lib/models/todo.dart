class Todo {

  String? title;
  String description;
  String? category;
  String? todoDate;
  int isFinished;

  Todo({

     this.title,
    required this.description,
     this.category,
     this.todoDate,
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
