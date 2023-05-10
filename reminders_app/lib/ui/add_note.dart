import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/note_controller.dart';
import '../models/node.dart';

class AddNotePage extends StatelessWidget {
  final NoteController noteController = Get.find();
  final Note? note;

  AddNotePage({this.note});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (note != null) {
      titleController.text = note!.title;
      contentController.text = note!.content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(note != null ? 'Edit Note' : 'Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final content = contentController.text;
                if (title.isEmpty || content.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Title and content cannot be empty.',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                } else {
                  if (note != null) {
                    noteController.updateNote(
                      note!,
                      title: title,
                      content: content,
                    );
                    Get.back();
                  } else {
                    final newNote = Note(
                      title: title,
                      content: content,
                    );
                    noteController.addNote(newNote);
                    Get.back();
                  }
                }
              },
              child: Text(note != null ? 'Update Note' : 'Add Note'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
