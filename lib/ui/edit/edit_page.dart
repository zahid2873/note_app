import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/ui/edit/menu_item_color.dart';

class EditPage extends StatelessWidget {
  final int index;

  EditPage({
    Key? key,
    required this.index,
  }) : super(key: key);

  final noteController = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoteController>(
      builder: (noteController){
      return Scaffold(
        backgroundColor: noteController.notes[index].color,
        appBar: AppBar(
          backgroundColor: getBackground(noteController.notes[index].color!),
          title: noteController.isEdit != false
              ? const Text("Edit Note")
              : const Text("Add Note"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          actions: [
            PopupMenuButton(
              position: PopupMenuPosition.under,
              itemBuilder: (context) => [
                PopupMenuItem(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MenuItemColor(index: index),
                ),
                PopupMenuItem(
                  onTap: () {
                    noteController.deleteNote(index);
                    Navigator.pop(context);
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text("Delete")
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: GetBuilder<NoteController>(builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      controller.updateNote(index);
                    },
                    controller: controller.titleController,
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                    decoration: noteController.isEdit == false
                        ? const InputDecoration(
                            labelText: "Title",
                            border: InputBorder.none,
                          )
                        : const InputDecoration(
                            border: InputBorder.none,
                          ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .95 - 90,
                    child: TextField(
                      maxLines: null,
                      minLines: null,
                      expands: true,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        controller.updateNote(index);
                      },
                      controller: controller.contentController,
                      decoration: noteController.isEdit == false
                          ? const InputDecoration(
                              label: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Content")),
                              border: InputBorder.none,
                            )
                          : const InputDecoration(
                              border: InputBorder.none,
                            ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      );
      }
    );
  }

  Color getBackground(Color color) {
    final Color newColor = Color.fromARGB(255, darken(color.red), darken(color.green), darken(color.blue));
    return newColor;
  }

  int darken(int number) {
    final num = number - number * 0.10;
    if (num > 255) {
      return 255;
    } else {
      return num.toInt();
    }
  }
}
