import 'package:get/get.dart';
import 'package:note_keeper_app/model/noteModel.dart';
import 'package:note_keeper_app/utils/databaseHelper.dart';

class NoteController extends GetxController {
  DatabaseHelper databaseHelper = DatabaseHelper();
  var noteList = <Note>[].obs; // Make it reactive
  var count = 0.obs; // Make it reactive

  Future<void> updateNoteList() async {
    try {
      final database = await DatabaseHelper().initializeDatabase();
      List<Note> updatedNoteList = await DatabaseHelper().getNoteList();
      noteList.value = updatedNoteList;
      count.value = updatedNoteList.length;
    } catch (e) {
      print('Error updating note list: $e');
    }
  }

  Future addNote(Note note) async {
    databaseHelper.insertNote(note);
    updateNoteList();
  }

  Future deleteNote(id) async {
    await databaseHelper.deleteNote(id);
    updateNoteList();
  }
}
