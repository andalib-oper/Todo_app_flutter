import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';
import '../models/todo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = Todo.todoList();
  List<Todo> _foundTodo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundTodo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    margin: const EdgeInsets.only(bottom: 70),
                child: Column(children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: const Text('All Todos',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500))),
                        for (Todo todo in _foundTodo)
                          Todo_Item(
                              toDo: todo,
                              onTodoChanged: _handleTodoChange,
                              onDeleteItem: _deleteTodoItem)
                      ],
                    ),
                  )
                ])),
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(children: [
                  Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 20, right: 20, left: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 0.0)
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextField(
                              controller: _todoController,
                              decoration: const InputDecoration(
                                  hintText: 'Add Todo Items',
                                  border: InputBorder.none)))),
                  Container(
                      margin: const EdgeInsets.only(bottom: 20, right: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: tdBlue,
                            shape: RoundedRectangleBorder(
                              side: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 10),
                        onPressed: () {
                          _addTodoItem(_todoController.text);
                        },
                        child: (const Text(
                          '+',
                          style: TextStyle(
                              fontSize: 40,
                              color: tdBlack,
                              decoration: TextDecoration.none),
                        )),
                      ))
                ]))
          ],
        ));
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteTodoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoItem(String todo) {
    setState(() {
      todosList.add(Todo(id: DateTime.now().toString(), todoText: todo));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeywords) {
    List<Todo> results = [];
    if (enteredKeywords.isEmpty) {
      setState(() {
        results = todosList;
      });
    } else {
      setState(() {
        results = todosList
            .where((item) => item.todoText!
                .toLowerCase()
                .contains(enteredKeywords.toLowerCase()))
            .toList();
      });
    }
    setState(() {
      _foundTodo = results;
    });
  }

  Widget searchBox() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: (TextField(
            onChanged: (value) => _runFilter(value),
            decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ))));
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: ClipRect(child: Image.asset('assets/images/avatar.jpg')),
        )
      ]),
    );
  }
}
