import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/constant/color_palette.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/db_helper/db_helper.dart';
import 'package:note_app/ui/edit/menu_item1.dart';
import 'package:note_app/ui/edit/menu_item2.dart';

class EditPage extends StatefulWidget {
  int index;

  EditPage({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final noteController = Get.find<NoteController>();

  @override
  void initState() {
    super.initState();
   // noteController.setEdit(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: noteController.isEdit != false? const Text("Edit Note"):const Text("Add Note"),
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
                     PopupMenuItem(child: MenuItem1()),
                     PopupMenuItem(child: MenuItem2(index: widget.index))
                  ])
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: GetBuilder<NoteController>(
            builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    controller.updateNote(widget.index);
                  },
                  controller: controller.titleController,
                  decoration: noteController.isEdit==false? const InputDecoration(
                    labelText: "Title",
                    border: InputBorder.none,
                  ):const InputDecoration(
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
                      controller.updateNote(widget.index);
                    },
                    controller: controller.contentController,
                    decoration: noteController.isEdit==false? const InputDecoration(

                      label: Align(
                        alignment: Alignment.topLeft,
                          child: Text("Content")),
                      border: InputBorder.none,
                    ):const InputDecoration(
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
}
