import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/constant/color_palette.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/db_helper/db_helper.dart';
import 'package:note_app/model/note_model.dart';

class NoteController extends GetxController {
  bool isLoading = false;
  List<NoteModel> notes = [];
  bool isMultiSelect = false;
  NoteModel? note;
  var deleteList = [];

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
        title: '',
        content: '',
        timestamp: Timestamp.now());
    String documentId = await DbHelper.addNote(noteModel);
    fetchNotes();
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
        color: getColor(docId),
        timestamp: Timestamp.now());
    DbHelper.updateNote(docId, noteModel);
    update();
    fetchNotes();
  }

  getColor(String docID) {
    fetchNotes();
    if (notes.isEmpty) return;
    NoteModel noteModel = notes.firstWhere(
      (element) => element.documentId == docID,
      orElse: () {
        throw Exception('No element found with documentId: $docID');
      },
    );
    //if (noteModel.isBlank ?? false) return;
    if (noteModel.documentId == docID) {
      return noteModel.color;
    }
    return ColorPalette.teal;
  }

  updateNoteColor(String docId, int selectedColor) {
    note?.color = selectedColor;
    final noteModel = NoteModel(
        uid: authController.user!.uid,
        documentId: docId,
        title: titleController.text,
        content: contentController.text,
        color: selectedColor,
        timestamp: Timestamp.now());
    DbHelper.updateNote(docId, noteModel);
    update();
    fetchNotes();
  }

  clearField() async {
    note = await null;
    titleController.clear();
    contentController.clear();
    update();
  }

  deleteNote(String documentId) async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      DbHelper.deleteNote(documentId);
    });
    fetchNotes();
  }

  void enableMultiSelect(int index) {
    isMultiSelect = true;
    notes[index].isSelected = true;
    update();
  }

  void disableMultiSelect() {
    isMultiSelect = false;
  }

  void selectNote(int index) {
    notes[index].isSelected = true;
    update();
  }

  void unSelectNote(int index) {
    notes[index].isSelected = false;
    var list = notes.where(
      (element) => element.isSelected,
    );
    if (list.isEmpty) {
      disableMultiSelect();
    }
    update();
  }

  void deleteSelectedNote() async {
    isLoading = true;
    update();
    disableMultiSelect();
    List<NoteModel> list = notes
        .where(
          (element) => element.isSelected,
        )
        .toList();
    if (await DbHelper.batchDelete(list)) {
      for (var element in list) {
        notes.removeWhere((value) => value.documentId == element.documentId);
      }
    }
    isLoading = false;
    update();
  }
}
