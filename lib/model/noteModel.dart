// To parse this JSON data, do
//
//     final note = noteFromJson(jsonString);

import 'dart:convert';

Note noteFromJson(String str) => Note.fromJson(json.decode(str));

String noteToJson(Note data) => json.encode(data.toJson());

class Note {
    int? id;
    String? title;
    String? description;
    String? date;
    int? priority;

    Note({
        this.id,
        this.title,
        this.description,
        this.date,
        this.priority,
    });

    factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        date: json["date"],
        priority: json["priority"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date,
        "priority": priority,
    };
}
