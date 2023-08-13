import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/constant/color_palette.dart';
import 'package:note_app/controller/note_controller.dart';

class MenuItemColor extends StatelessWidget {
  final int index;
  final controller = Get.find<NoteController>();
  MenuItemColor({Key? key, required this.index}) : super(key: key);

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
              controller.updateNoteColor(index, ColorPalette.lightBlue);
              Navigator.of(context).pop();
            },
            icon: const CircleAvatar(
              backgroundColor: ColorPalette.lightBlue,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.updateNoteColor(index, ColorPalette.lightGreen);
              Navigator.of(context).pop();
            },
            icon: const CircleAvatar(
              backgroundColor: ColorPalette.lightGreen,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.updateNoteColor(index, ColorPalette.yellow);
              Navigator.of(context).pop();
            },
            icon: const CircleAvatar(
              backgroundColor: ColorPalette.yellow,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.updateNoteColor(index, ColorPalette.pink);
              Navigator.of(context).pop();
            },
            icon: const CircleAvatar(
              backgroundColor: ColorPalette.pink,
            ),
          ),
        ],
      ),
    );
  }
}
