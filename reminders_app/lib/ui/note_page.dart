import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/note_controller.dart';
import 'add_note.dart';

class NotePage extends StatelessWidget {
  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Obx(
        () => GridView.builder(
          itemCount: noteController.notes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (BuildContext context, int index) {
            final note = noteController.notes[index];
            return GestureDetector(
              onTap: () => Get.to(AddNotePage(note: note)),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        note.title,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => noteController.deleteNote(note),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(AddNotePage()),
        child: Icon(Icons.add),
      ),
    );
  }
}
