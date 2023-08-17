import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/constant/color_palette.dart';
import 'package:note_app/controller/note_controller.dart';

class MenuItemColor extends StatelessWidget {
  String documentId;

  MenuItemColor({Key? key, required this.documentId}) : super(key: key);

  final controller = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showInputDialog(context);
      },
      child: const Row(
        children: [
          Icon(
            Icons.color_lens,
            color: Colors.black,
          ),
          SizedBox(width: 10),
          Text("Color")
        ],
      ),
    );
  }

  showInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Color"),
        actionsAlignment: MainAxisAlignment.start,
        actions: [
          IconButton(
            onPressed: () {
              //controller.updateNoteColor(index, ColorPalette.lightBlue);
              //controller.selectedColor = ColorPalette.colorLightBlue;
              controller.updateNoteColor(documentId, ColorPalette.brown);
              Navigator.of(context).pop();
            },
            icon: const CircleAvatar(
              backgroundColor: Color(0xFFDBFE87),
            ),
          ),
          IconButton(
            onPressed: () {
              controller.updateNoteColor(documentId, ColorPalette.yellow);
              Navigator.of(context).pop();
            },
            icon: const CircleAvatar(
              backgroundColor: Color(0xFFFFFD82),
            ),
          ),
          IconButton(
            onPressed: () {
              controller.updateNoteColor(documentId, ColorPalette.teal);
              Navigator.of(context).pop();
            },
            icon: const CircleAvatar(
              backgroundColor: Color(0xFF1BE7FF),
            ),
          ),
          IconButton(
            onPressed: () {
              controller.updateNoteColor(documentId, ColorPalette.grayis);
              Navigator.of(context).pop();
            },
            icon: const CircleAvatar(
              backgroundColor: Color(0xFFE0E1DD),
            ),
          ),
        ],
      ),
    );
  }
}
