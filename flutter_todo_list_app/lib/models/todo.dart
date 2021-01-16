
import 'dart:convert';

List<Todo> todoFromJson(String str) => List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

String todoToJson(List<Todo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todo {
    Todo({
        this.id,
        this.isFinished,
        this.title,
        this.date,
        this.v,
    });

    String id;
    bool isFinished;
    String title;
    DateTime date;
    int v;

    factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["_id"],
        isFinished: json["isFinished"],
        title: json["title"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "isFinished": isFinished,
        "title": title,
        "date": date.toLocal(),
        "__v": v,
    };
}
