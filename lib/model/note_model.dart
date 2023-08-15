import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String uid;
  String? title;
  String? content;
  String? color;
  Timestamp? timestamp;

  NoteModel(
      {required this.uid,
      this.title,
      this.content,
      this.color,
      this.timestamp});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      'content': content,
      'color': color,
      'timestamp': timestamp,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) => NoteModel(
        uid: map['uid'],
        title: map['title'],
        content: map['content'],
        color: map['color'],
        timestamp: map['timestamp'],
      );
}
