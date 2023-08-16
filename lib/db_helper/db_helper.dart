import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/model/note_model.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String _collectionNote = "Notes";

  static addNote(NoteModel noteModel) =>
      _db.collection(_collectionNote).doc().set(noteModel.toMap());

  // static Stream<DocumentSnapshot<Map<String, dynamic>>> getNoteById(
  //     String uid) =>
  //     _db.collection(_collectionNote).doc(uid).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getNoteById(
          String userId) =>
      _db
          .collection(_collectionNote)
          //.orderBy(noteTimestamp,descending: true)
          .where(noteUserId, isEqualTo: userId)
          //.orderBy(noteTimestamp,descending: true)
          .snapshots();

  static Future<void> removeNote(String uid, String timestamp) {
    return _db
        .collection(_collectionNote)
        .doc(uid)
        .collection(_collectionNote)
        .doc(timestamp)
        .delete();
  }
}
