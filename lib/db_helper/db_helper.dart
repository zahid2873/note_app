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
      String uid) =>
      _db
          .collection(_collectionNote)
          .where(_collectionNote, isEqualTo: uid)
          .snapshots();
}
