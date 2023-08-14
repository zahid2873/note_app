import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/model/note_model.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String _collectionNote = "Notes";

  static addNote(NoteModel noteModel) => _db
      .collection(_collectionNote)
      .doc()
      .set(noteModel.toMap());

}
