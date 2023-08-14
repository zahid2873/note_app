import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/constant/color_palette.dart';

class NoteModel {
  String uid;
  String? title;
  String? content;
  Color? color;
  Timestamp? timestamp;

  NoteModel(
      {required this.uid,
      this.title,
      this.content,
      this.color = ColorPalette.lightBlue,
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
