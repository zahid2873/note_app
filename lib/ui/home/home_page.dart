import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/controller/auth_controller.dart';
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
        title: const Text("Recent Notes"),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       Get.find<AuthController>().signOut();
          //     },
          //     icon: const Icon(Icons.logout)),
          PopupMenuButton(
            position: PopupMenuPosition.under,
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  GoRouter.of(context).pushNamed('profile_page');
                },
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text("Profile")
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  Get.find<AuthController>().signOut();
                },
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text("Logout")
                  ],
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<NoteController>().isEdit = false;
          final int index = Get.find<NoteController>().addNote();
          Get.find<NoteController>().clearField();
          GoRouter.of(context).pushNamed('edit_page',
              pathParameters: {'index': index.toString()});
          Get.find<NoteController>().addNotes();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<NoteController>(
          init: NoteController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: controller.notes.isEmpty
                  ? const CircularProgressIndicator()
                  : MasonryGridView.builder(
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
