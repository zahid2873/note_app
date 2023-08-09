import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/constant/color_palette.dart';
import 'package:note_app/model/note_model.dart';

class NoteController extends GetxController {
  List<NoteModel> notes = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  fetchNote() {
    update();
  }

  int addNote(){
    notes.add(NoteModel(color: ColorPalette.yellow,title: "", content: ""));
    return notes.indexOf(notes.last);
  }

   setEdit(int index) {
    titleController.text=notes[index].title ?? '';
    contentController.text=notes[index].content ?? '';
  }

  updateNote(int index){
    notes[index]= NoteModel(title: titleController.text,content:   contentController.text);
    update();
  }

  deleteNote(int index) async {
    await Future.delayed(const Duration(milliseconds: 500), (){
      notes.removeAt(index);
    });

    update();
  }
  setAdd() {
    notes.add(NoteModel(color: ColorPalette.yellow,title: "", content: ""));
    //update();
  }
}
