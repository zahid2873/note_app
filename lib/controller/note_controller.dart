import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/model/note_model.dart';

import '../db_helper/db_helper.dart';

class NoteController extends GetxController {
  bool isSignIn = false;
  List<NoteModel> notes = [];
  bool isEdit = true;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final authController = Get.find<AuthController>();
  @override
  void onInit() {
    super.onInit();
    fetchNote();
  }

  // fetchNote() {
  //   notes.addAll([
  //     NoteModel(
  //         color: ColorPalette.pink,
  //         title: "title jsd jsdkjd jsdkjd",
  //         content:
  //             "The decade that brought us Star Trek and Doctor Who also resurrected Cicero—or at least what used to be Cicero—in an attempt to make the days before computerized design a little less painstakingThe French lettering company Letraset manufactured a set of dry-transfer sheets which included the lorem ipsum filler text in a variety of fonts, sizes, and layouts. These sheets of lettering could be rubbed on anywhere and were quickly adopted by graphic artists, printers, architects, and advertisers for their professional look and ease of use.Aldus Corporation, which later merged with Adobe Systems, ushered lorem ipsum into the information age with its desktop publishing software Aldus PageMaker. The program came bundled with lorem ipsum dummy text for laying out page content, and other word processors like Microsoft Word followed suit. More recently the growth of web design has helped proliferate lorem ipsum across the internet as a placeholder for future text and in some cases the final content this is why we proofread, kids."),
  //     NoteModel(
  //         color: ColorPalette.lightBlue,
  //         title: "",
  //         content:
  //             "The decade that brought us Star Trek and Doctor Who also resurrected Cicero—or at least what used to be Cicero—in an attempt to make the days before computerized design a little less painstakingThe French lettering company Letraset manufactured a set of dry-transfer sheets which included the lorem ipsum filler text in a variety of fonts, sizes, and layouts. These sheets of lettering could be rubbed on anywhere and were quickly adopted by graphic artists, printers, architects, and advertisers for their professional look and ease of use.Aldus Corporation, which later merged with Adobe Systems, ushered lorem ipsum into the information age with its desktop publishing software Aldus PageMaker. The program came bundled with lorem ipsum dummy text for laying out page content, and other word processors like Microsoft Word followed suit. More recently the growth of web design has helped proliferate lorem ipsum across the internet as a placeholder for future text and in some cases the final content this is why we proofread, kids."),
  //     NoteModel(
  //         color: ColorPalette.lightGreen,
  //         title: "title",
  //         content:
  //             " ters, architects, and advertisers for their professional look and ease of use."),
  //     NoteModel(
  //         color: ColorPalette.yellow,
  //         title: "title",
  //         content:
  //             "The decade that brought us Star Trek and Doctor Who also resurrected Cicero—or at least what used to be Cicero—in an attempt to make the days before computerized design a little less painstakingThe French lettering company Letraset manufactured a set of dry-transfer sheets which included the lorem ipsum filler text in a variety of fonts, sizes, and layouts. These sheets of lettering could be rubbed on anywhere and were quickly adopted by graphic artists, printers, architects, and advertisers for their professional look and ease of use.Aldus Corporation, which later merged with Adobe Systems, ushered lorem ipsum into the information age with its desktop publishing software Aldus PageMaker. The program came bundled with lorem ipsum dummy text for laying out page content, and other word processors like Microsoft Word followed suit. More recently the growth of web design has helped proliferate lorem ipsum across the internet as a placeholder for future text and in some cases the final content this is why we proofread, kids."),
  //     NoteModel(
  //         color: ColorPalette.yellow,
  //         title: "title",
  //         content:
  //             "The decade that brought us Star Trek and Doctor Who also resurrected Cicero—or at least what used to be Cicero—in an attempt to make the days before computerized design a little less painstakingThe French lettering company Letraset manufactured a set of dry-transfer sheets which included the lorem ipsum filler text in a variety of fonts, sizes, and layouts. These sheets of lettering could be rubbed on anywhere and were quickly adopted by graphic artists, printers, architects, and advertisers for their professional look and ease of use.Aldus Corporation, which later merged with Adobe Systems, ushered lorem ipsum into the information age with its desktop publishing software Aldus PageMaker. The program came bundled with lorem ipsum dummy text for laying out page content, and other word processors like Microsoft Word followed suit. More recently the growth of web design has helped proliferate lorem ipsum across the internet as a placeholder for future text and in some cases the final content this is why we proofread, kids."),
  //     NoteModel(
  //         color: ColorPalette.lightBlue,
  //         title: "title",
  //         content:
  //             "The decade that brought us Star Trek and Doctor Who also resurrected Cicero—or at least what used to be Cicero—in an attempt to make the days before computerized design a little less painstakingThe French lettering company Letraset manufactured a set of dry-transfer sheets which included the lorem ipsum filler text in a variety of fonts, sizes, and layouts. These sheets of lettering could be rubbed on anywhere and were quickly adopted by graphic artists, printers, architects, and advertisers for their professional look and ease of use.Aldus Corporation, which later merged with Adobe Systems, ushered lorem ipsum into the information age with its desktop publishing software Aldus PageMaker. The program came bundled with lorem ipsum dummy text for laying out page content, and other word processors like Microsoft Word followed suit. More recently the growth of web design has helped proliferate lorem ipsum across the internet as a placeholder for future text and in some cases the final content this is why we proofread, kids."),
  //     NoteModel(color: ColorPalette.lightGreen, content: "content"),
  //     NoteModel(color: ColorPalette.pink, title: "", content: "content"),
  //     NoteModel(title: "title", content: "content"),
  //     NoteModel(
  //         title: "title",
  //         content:
  //             "make the days before computerized design a little less painstakingThe French lettering company Letraset manufactured a set of dry-transfer sheets which included the lorem ipsum filler text in a variety of fonts, sizes, and layouts. These sheets of lettering could be rubbed on anywhere and were quickly adopted by graphic artists, printers, architects, and advertisers for their professional look and ease of use.Aldus Corporation, which later merged with Adobe Systems, ushered lorem ipsum into the information age with its desktop publishing software Aldus PageMaker. The program came bundled with lorem ipsum dummy text for laying out page content, and other word processors like Microsoft Word followed suit. More recently the growth of web design has helped proliferate lorem ipsum across the internet as a placeholder for future text and in some cases the final content this is why we proofread, kids."),
  //     NoteModel(
  //         title: "title",
  //         content:
  //             "content hhhhhhhhhhhhhhh hhhhhhhhhhhhhh hhhhhhhhhhhh bbbbbbbbbb"),
  //     NoteModel(title: "title", content: "content"),
  //     NoteModel(title: "title", content: "content"),
  //   ]);
  //   // update();
  // }

  int addNote() {
    notes.add(NoteModel(
        uid: '',
        timestamp: Timestamp.now(),
        color: "",
        title: "",
        content: ""));
    update();
    return notes.indexOf(notes.last);
  }

  setEdit(int index) {
    titleController.text = notes[index].title ?? '';
    contentController.text = notes[index].content ?? '';
  }

  updateNote(int index) {
    notes[index]
      ..timestamp = Timestamp.now()
      ..title = titleController.text
      ..content = contentController.text;
    update();
  }

  updateNoteColor(int index, Color color) {
    notes[index].color = "";
    update();
  }

  deleteNote(int index) async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      notes.removeAt(index);
    });

    update();
  }

  setAdd() {
    notes.add(NoteModel(uid: '', color: "", title: "", content: ""));
    //update();
  }

  clearField() {
    titleController.clear();
    contentController.clear();
  }

  addNotes() {
    final noteModel = NoteModel(
        uid: authController.user!.uid,
        title: titleController.text,
        content: contentController.text,
        timestamp: Timestamp.now());
    DbHelper.addNote(noteModel);
    update();
  }

  fetchNote() {
     DbHelper.getNoteById(authController.user!.uid)
        .listen((snapshot) {
      notes = List.generate(snapshot.docs.length,
          (index) => NoteModel.fromMap(snapshot.docs[index].data()));
      update();
    });

  }

   deletedNote(String timestamp) {
    DbHelper.removeNote(authController.user!.uid, timestamp);
    update();
  }
}
