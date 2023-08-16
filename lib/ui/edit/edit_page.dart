import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/controller/note_controller.dart';

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

  @override
  void initState() {
    super.initState();
    noteController.fetchNote(widget.documentId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoteController>(builder: (noteController) {
      return Scaffold(
        //backgroundColor: ,
        appBar: AppBar(
          //backgroundColor: getBackground(noteController.notes[index].color!),
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
                // PopupMenuItem(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: MenuItemColor(index: index),
                // ),
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
