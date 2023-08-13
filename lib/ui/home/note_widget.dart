import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:note_app/constant/color_palette.dart';
import 'package:note_app/model/note_model.dart';
import 'package:note_app/ui/common/helper_function.dart';

class NoteWidget extends StatelessWidget {
  Callback onTap;
  NoteModel noteInfo;
  NoteWidget({Key? key, required this.noteInfo, required this.onTap})
      : super(key: key);

  ColorPalette color = ColorPalette();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: noteInfo.color,
            borderRadius: BorderRadius.circular(15)),
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
                    getFormattedDate(noteInfo.timestamp!.toDate(),
                        "dd/MM/yyyy HH:mm"),
                    style: TextStyle(color: Colors.grey, fontSize: 12),
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
