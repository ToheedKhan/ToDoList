import 'package:flutter/material.dart';
import 'package:clear/task.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
//import './widget/strikeThrough.dart';

void main() => runApp(MyApp());

// void main() {
//   runApp(MaterialApp(
//     title: "Personal List App",
//     home: PersonalList(),
//     // theme: ThemeData(
//     //   primarySwatch: Colors.black,
//     // ),
//   ));
// }
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dismissible',
      theme: ThemeData(
        primarySwatch: Colors.black,
      ),
      home: PersonalList(),
    );
  }
}

class PersonalList extends StatefulWidget {
  @override
  PersonalListState createState() {
    return PersonalListState();
  }
}

class PersonalListState extends State<PersonalList> {
  List<String> items = ["Item 1", "Item 2", "Item 3"];
  final List<Task> tasks = [];

  final TextEditingController _textFieldController = TextEditingController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal List"),
      ),
      body: ReorderableListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final todo = tasks[index].getName();
          return Dismissible(
            key: Key('$todo$index'),
            child: Card(
              key: ValueKey(todo),
              elevation: 1,
              child: ListTile(
                title: Text(todo,
                    style: (false
                        ? TextStyle(decoration: TextDecoration.lineThrough)
                        : TextStyle(decoration: TextDecoration.none))),
                contentPadding: EdgeInsets.all(5),
                onTap: () {
                  Text(todo,
                      style: (true
                          ? TextStyle(decoration: TextDecoration.lineThrough)
                          : TextStyle(decoration: TextDecoration.none)));
                },
              ),
            ),
            background: slideRightBackground(),
            secondaryBackground: slideLeftBackground(),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                setState(() {
                  items.removeAt(index);
                });
              } else {
                setState(() {
                  print('Called');
                  Text(todo,
                      style: (true
                          ? TextStyle(decoration: TextDecoration.lineThrough)
                          : TextStyle(decoration: TextDecoration.none)));
                });
              }
            },
          );
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            var getReplacedWidget = items.removeAt(oldIndex);
            items.insert(newIndex, getReplacedWidget);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(context),
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.check,
              color: Colors.white,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.clear,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
  void _addTodoItem(String name) {
    //Wrapping it inside a set state will notify
    // the app that the state has changed

    setState(() {
      // _todoList.add(title);
      tasks.add(Task(name));
    });
    _textFieldController.clear();
  }

  //Generate a single item widget
  Future<AlertDialog> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task to your List'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Enter task here'),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                },
              ),
              FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
