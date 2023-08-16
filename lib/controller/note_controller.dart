import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/db_helper/db_helper.dart';
import 'package:note_app/model/note_model.dart';

class NoteController extends GetxController {
  bool isLoading = false;
  List<NoteModel> notes = [];
  NoteModel? note;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final authController = Get.find<AuthController>();
  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  Future<String> addNote() async {
    final noteModel = NoteModel(
        uid: authController.user!.uid,
        documentId: '',
        title: titleController.text,
        content: contentController.text,
        timestamp: Timestamp.now());
    String documentId = await DbHelper.addNote(noteModel);
    update();
    return documentId;
  }

  fetchNotes() async {
    isLoading = true;
    update();
    notes =
        await DbHelper.getNotes(authController.user!.uid) as List<NoteModel>;
    isLoading = false;
    update();
  }

  fetchNote(String documentId) async {
    clearField();
    note = await DbHelper.getNote(documentId);
    print(note!.title);
    titleController.text = note?.title ?? "";
    contentController.text = note?.content ?? "";
    update();
  }

  updateNote(String docId) {
    final noteModel = NoteModel(
        uid: authController.user!.uid,
        documentId: docId,
        title: titleController.text,
        content: contentController.text,
        timestamp: Timestamp.now());
    DbHelper.updateNote(docId, noteModel);
    update();
    fetchNotes();
  }

  clearField() {
    titleController.clear();
    contentController.clear();
  }

  deleteNote(String documentId) async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      DbHelper.deleteNote(documentId);
    });
    fetchNotes();
  }

  // updateNoteColor(int index, Color color) {
  //   notes[index].color = "";
  //   update();
  // }
}
