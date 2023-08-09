import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';
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
  final controller = Get.find<NoteController>();

  @override
  void initState() {
    super.initState();
    controller.setEdit(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Edit Note"),
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
                    const PopupMenuItem(child: MenuItem1()),
                     PopupMenuItem(child: MenuItem2(index: widget.index))
                  ])
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
                    controller.updateNote(widget.index);
                  },
                  controller: controller.titleController,
                  decoration: const InputDecoration(
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
                    decoration: const InputDecoration(
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
