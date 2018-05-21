import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/newtodo.dart';

class ToDoList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("ToDo List"),
        ),
        body: new Padding(
          padding: new EdgeInsets.all(8.0),
          child: new FutureBuilder<List<String>>(
            future: todoList(),
            builder: (context, snapshot) {
              return _buildToDoList(snapshot);
            }
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.ac_unit),
          onPressed: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) => new NewToDo()));
          }));
  }

  Widget _buildToDoList(AsyncSnapshot<List<String>> snapshot) {
    final todos = snapshot.data;
    if (todos == null) {
      return new Container();
    }
    switch(snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting: return new CircularProgressIndicator();
      default:
      return new ListView.builder(
        itemBuilder: (context, index) => new Text(todos[index]),
        itemCount: todos.length,
      );
    }
  }

  Future<List<String>> todoList() async {
      final prefs = await SharedPreferences.getInstance();
      final todoList = prefs.getStringList(todoListKey);
      return todoList;
  }
}