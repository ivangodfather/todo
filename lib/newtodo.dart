import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final todoListKey = "toDoList";
class NewToDo extends StatefulWidget {
  @override
  _NewToDoState createState() => new _NewToDoState();
}

class _NewToDoState extends State<NewToDo> {
  String _task;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void _saveToDo() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final prefs = await SharedPreferences.getInstance();
      List<String> todoList = prefs.getStringList(todoListKey);
      List<String> newToDoList = List.from(todoList)..add(_task);
      prefs.setStringList(todoListKey, newToDoList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Create a ToDo item"),
      ),
      body: new Form(
        key: _formKey,
        child: new Column(
          children: <Widget>[
            new TextFormField(
                onSaved: (text) => _task = text,
                decoration:
                new InputDecoration(hintText: "Enter your todo task"),
                validator: (text) {
                  if (text.isEmpty) {
                    return "Can't be null";
                  }
                }),
            new RaisedButton(
              onPressed: () {
                _saveToDo();
              },
              child: new Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
