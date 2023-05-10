import 'package:get/get.dart';

import '../models/node.dart';

class NoteController extends GetxController {
  RxList<Note> notes = <Note>[].obs;

  void addNote(Note note) {
    notes.add(note);
  }

  void updateNote(Note note, {required String title, required String content}) {
    note.title = title;
    note.content = content;
  }

  void deleteNote(Note note) {
    notes.remove(note);
  }
}
