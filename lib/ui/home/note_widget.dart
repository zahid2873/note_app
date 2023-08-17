import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:note_app/constant/color_palette.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/model/note_model.dart';
import 'package:note_app/ui/common/helper_function.dart';

class NoteWidget extends StatelessWidget {
  final NoteModel noteInfo;
  final Callback onTap;
  final Callback onLongPress;
  NoteWidget(
      {Key? key,
      required this.noteInfo,
      required this.onTap,
      required this.onLongPress})
      : super(key: key);

  final noteController = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: noteInfo.isSelected
              ? const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2, 2),
                      blurRadius: 3,
                      spreadRadius: 3)
                ]
              : const [
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(2, 2),
                      blurRadius: 3,
                      spreadRadius: 3)
                ],
          color: noteInfo.color != null
              ? Color(noteInfo.color!).withOpacity(1)
              : Color(ColorPalette.teal).withOpacity(1),
          borderRadius: BorderRadius.circular(15),
          border: noteInfo.isSelected
              ? Border.all(color: Colors.black)
              : Border.all(color: Colors.white),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            noteInfo.title == null
                ? const SizedBox()
                : Text(
                    noteInfo.title!,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
            noteInfo.timestamp == null
                ? const SizedBox()
                : Text(
                    getFormattedDate(
                        noteInfo.timestamp!.toDate(), "dd/MM/yyyy hh:mm a"),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
            const SizedBox(
              height: 5,
            ),
            Text(
              noteInfo.content ?? "",
              softWrap: false,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
