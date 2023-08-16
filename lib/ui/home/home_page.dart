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
  final noteController = Get.put(NoteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Recent Notes"),
        actions: [
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
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'btn1',
            onPressed: () async {
              // var documentId = await noteController.addNotes();
              //  GoRouter.of(context).pushNamed('edit_page',pathParameters: {'documentId': documentId});
              noteController.addNote().then((documentId) {
                GoRouter.of(context).pushNamed('edit_page',
                    pathParameters: {'documentId': documentId});
              }).onError((error, stackTrace) {
                debugPrint(error.toString());
                debugPrint(stackTrace.toString());
              });
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 5),
          FloatingActionButton(
            heroTag: 'btn2',
            onPressed: () async {
              // var documentId = await noteController.addNotes();
              //  GoRouter.of(context).pushNamed('edit_page',pathParameters: {'documentId': documentId});
              noteController.fetchNotes();
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: GetBuilder<NoteController>(
          init: NoteController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : MasonryGridView.builder(
                      shrinkWrap: true,
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
                            GoRouter.of(context)
                                .pushNamed('edit_page', pathParameters: {
                              'documentId': controller.notes[index].documentId
                            });
                          },
                        );
                      },
                    ),
            );
          }),
    );
  }
}
