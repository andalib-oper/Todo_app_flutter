class Todo {
  String? id;
  String? todoText;
  bool isDone = false;

Todo({
  required this.id,
  required this.todoText,
  this.isDone = false,
});

 static List<Todo> todoList(){
  return[
    Todo(id: '0', todoText: 'Buy milk', isDone: true),
    Todo(id: '1', todoText: 'Buy eggs'),
    Todo(id: '2', todoText: 'Buy bread', isDone: true),
    Todo(id: '3', todoText: 'Buy flour'),
    Todo(id: '4', todoText: 'Buy sugar'),
    Todo(id: '5', todoText: 'Buy Onion', isDone: true),
    Todo(id: '6', todoText: 'Buy Potato'),
    Todo(id: '7', todoText: 'Buy Beans'),
  ];
}
}