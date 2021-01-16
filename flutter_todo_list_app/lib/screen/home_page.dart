import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/Api/api.dart';
import 'package:flutter_todo_list_app/components/todo_card.dart';
import 'package:flutter_todo_list_app/mixins/validation_mixin.dart';
import 'package:flutter_todo_list_app/models/todo.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  List<Todo> todo = new List<Todo>();
  var _controller = TextEditingController();

  String todonameTxt = "";
  @override
  void initState() {
    super.initState();
    getTodo();
  }

//get todo
  getTodo() {

    try {
         Api.getTodos().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        // print(list);
        this.todo = list.map((todos) => Todo.fromJson(todos)).toList();
        //en son eklenen en başta gözükecekse
        // this.todo.sort((a, b) {
        //   var adate = a.date;
        //   var bdate = b.date;
        //   return -adate.compareTo(bdate);
        // });
      });
    });
    } catch (e) {
      print(e);
    }
 
  }

//delete todo
  deleteTodo(_id,title) {
    Api.deleteTodo(_id).then((response) {
      toast(title+" Görevi Silindi");
    });
    getTodo();
  }

  //update todo
  updateTodo(_id, isfinished,title) {
    Api.updateTodo(_id, isfinished).then((response) {
      isfinished ? toast(title+" Görevi Tamamlandı") : toast(title+" Görevi geri alındı");
    });
    getTodo();
  }

//add Todo
  addTodo() {
    Api.addTodo(todonameTxt).then((response) {
      _controller.clear();
      toast("Görev Eklendi.");
    });
    getTodo();
  }

//toast method
  void toast(msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: todo.length,
        itemBuilder: (context, position) {
          return Dismissible(
            onDismissed: (direction) {
              deleteTodo(todo[position].id,todo[position].title);
            },
            background: slideBackground(),
            secondaryBackground: slideBackground(),
            key: UniqueKey(),
            child: TodoCard(
              title: todo[position].title,
              date: todo[position].date,
              isFinished: todo[position].isFinished,
              function: (isfinished) {
                updateTodo(todo[position].id, isfinished,todo[position].title);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          addTodoPage(context),
        },
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),
    );
  }

  Future addTodoPage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 160,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () => _controller.clear(),
                              icon: Icon(Icons.clear),
                            ),
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            labelText: 'Todo Name',
                            hintText: 'Todo name'),
                        validator: validateTodoName,
                        onSaved: (newValue) {
                          todonameTxt = newValue;
                        },
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              formKey.currentState.save();
                              addTodo();
                            }
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: const Color(0xff845EC2),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

Widget slideBackground() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red[400],
      ),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Sil",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    ),
  );
}

