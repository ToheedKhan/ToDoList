import 'package:flutter/material.dart';

class StrikeThrough extends StatelessWidget {

  final String todoText;
  final bool todoCheck;

  StrikeThrough(this.todoText, this.todoCheck) : super();

  Widget _widget() {
    if (todoCheck) {
      return Text(
        todoText,
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
          fontStyle: FontStyle.italic,
          fontSize: 22.0,
          color: Colors.red[200],
        ),
      );
    }
    else {
      return Text(
        todoText,
        style: TextStyle(
            fontSize: 22.0
        ),
      );
    }
  }
}