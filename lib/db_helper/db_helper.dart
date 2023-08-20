import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:note_app/model/note_model.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String _collectionNote = "Notes";

  static addNote(NoteModel noteModel) async {
    late String id;
    await _db.collection(_collectionNote).add(noteModel.toMap()).then((value) {
      print("doc id ${value.id}");
      id = value.id;
    });
    return id;
  }

  static Future<NoteModel?> getNote(String documentId) async {
    var snapshot = await _db.collection(_collectionNote).doc(documentId).get();

    return NoteModel.fromMap(
        snapshot.id, snapshot.data() as Map<String, dynamic>);
  }

  static Future<List<NoteModel>?> getNotes(String userId) async {
    List<NoteModel>? notes;
    await _db
        .collection(_collectionNote)
        .where(noteUserId, isEqualTo: userId)
        .get()
        .then((snapshot) {
      notes = List.generate(
          snapshot.docs.length,
          (index) => NoteModel.fromMap(
              snapshot.docs[index].id, snapshot.docs[index].data()));
    });
    return notes;
  }

  static updateNote(String docId, NoteModel noteModel) async {
    await _db.collection(_collectionNote).doc(docId).set(noteModel.toMap());
  }

  static deleteNote(String documentId) {
    _db.collection(_collectionNote).doc(documentId).delete();
  }

  // static deleteNote(String documentId) {
  //   _db.collection(_collectionNote).get().then((snapshot) {
  // for (DocumentSnapshot ds in snapshot.docs.where(('field') == 'specificValue'){
  //   ds.reference.delete();
  //   });
  // });
  // }

  static Future<bool> batchDelete(List<NoteModel> docList) async {
    try {
      WriteBatch batch = _db.batch();
      for (var element in docList) {
        final documnet =
            _db.collection(_collectionNote).doc(element.documentId);
        batch.delete(documnet);
      }

      await batch.commit();
    } on Exception catch (e, s) {
      debugPrint("Error: $e, Stack: $s");
      return false;
    }
    return true;
  }
}
