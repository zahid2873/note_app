import 'package:cloud_firestore/cloud_firestore.dart';

const String noteUserId = 'uid';
const String noteTimestamp = 'timestamp';

class NoteModel {
  String uid;
  String documentId;
  String? title;
  String? content;
  int? color;
  Timestamp? timestamp;

  NoteModel({
    required this.uid,
    required this.documentId,
    this.title,
    this.content,
    this.color,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      'content': content,
      'color': color,
      'timestamp': timestamp,
    };
  }

  factory NoteModel.fromMap(String documentId, Map<String, dynamic> map) =>
      NoteModel(
        uid: map['uid'],
        documentId: documentId,
        title: map['title'],
        content: map['content'],
        color: map['color'],
        timestamp: map['timestamp'],
      );
}
