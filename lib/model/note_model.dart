import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/constant/color_palette.dart';

class NoteModel {
  String? title;
  String? content;
  Color? color;
  Timestamp? timestamp;

  NoteModel(
      {this.title,
      this.content,
      this.color = ColorPalette.lightBlue,
      this.timestamp});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'color': color,
      'timestamp': timestamp,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) => NoteModel(
        title: map['title'],
        content: map['content'],
        color: map['color'],
        timestamp: map['timestamp'],
      );
}
