import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/constant/color_palette.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/model/note_model.dart';
import 'package:note_app/ui/edit/menu_item_color.dart';

class EditPage extends StatefulWidget {
  final String documentId;

  const EditPage({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final noteController = Get.find<NoteController>();
  NoteModel? note;

  @override
  void initState() {
    super.initState();
    noteController.fetchNote(widget.documentId);

    
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoteController>(builder: (noteController) {
      return Scaffold(
        backgroundColor: noteController.note?.color != null
                ? Color(noteController.note!.color!).withOpacity(1)
                : Color(ColorPalette.teal).withOpacity(1) ,
        appBar: AppBar(
          backgroundColor:  noteController.note?.color != null
                ? Color(noteController.note!.color!).withOpacity(1)
                : Color(ColorPalette.teal).withOpacity(1) ,
          title: const Text("Edit Note"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          actions: [
            PopupMenuButton(
              position: PopupMenuPosition.under,
              itemBuilder: (context) => [
                PopupMenuItem(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MenuItemColor(documentId: widget.documentId),
                ),
                PopupMenuItem(
                  onTap: () {
                    noteController.deleteNote(widget.documentId);
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
                      controller.updateNote(widget.documentId);
                    },
                    controller: controller.titleController,
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      labelText: "Title",
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
                        controller.updateNote(widget.documentId);
                      },
                      controller: controller.contentController,
                      decoration: const InputDecoration(
                        label: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Content")),
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
    });
  }

  Color getBackground(Color color) {
    final Color newColor = Color.fromARGB(
        255, darken(color.red), darken(color.green), darken(color.blue));
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
