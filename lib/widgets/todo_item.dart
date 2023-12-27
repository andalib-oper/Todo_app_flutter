import 'package:flutter/material.dart';
import 'package:to_do_flutter/constants/colors.dart';
import '../models/todo.dart';

class Todo_Item extends StatelessWidget {
final Todo toDo;
final onTodoChanged;
final onDeleteItem;

 const Todo_Item({ Key? key, required this.toDo, required this.onTodoChanged, required this.onDeleteItem }) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child:  ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: IconButton(
         icon: Icon(toDo.isDone? Icons.check_box:Icons.check_box_outline_blank), color: tdBlue,
         onPressed: () {
          
         },
         ),
        title: Text(
          toDo.todoText!,
        style:  TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: tdBlack,
          decoration: toDo.isDone ? TextDecoration.lineThrough: null,
        ),
        ),
        trailing: IconButton(
          icon:const Icon(Icons.delete),
          color: tdRed,
          onPressed: () {
            onDeleteItem(toDo.id);
          }),
        contentPadding: const EdgeInsets.all(10),
        enabled: true,
        onTap: () {
           onTodoChanged(toDo);
        },
      ),
    );
  }
}