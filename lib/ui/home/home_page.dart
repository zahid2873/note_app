import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/auth/auth_service.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/ui/home/note_widget.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  const Text("Recent Notes"),
        actions: [
          IconButton(
              onPressed: () {
                AuthService.signOut(context: context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<NoteController>().isEdit = false;
          final int index = Get.find<NoteController>().addNote();
          Get.find<NoteController>().clearField();
          GoRouter.of(context).pushNamed('edit_page',
              pathParameters: {'index': index.toString()});
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<NoteController>(
          init: NoteController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: MasonryGridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.notes.length,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return NoteWidget(
                    noteInfo: controller.notes[index],
                    onTap: () {
                      Get.find<NoteController>().isEdit = true;
                      Get.find<NoteController>().setEdit(index);
                      GoRouter.of(context).pushNamed('edit_page',
                          pathParameters: {'index': index.toString()});
                    },
                  );
                },
              ),
            );
          }),
    );
  }
}
