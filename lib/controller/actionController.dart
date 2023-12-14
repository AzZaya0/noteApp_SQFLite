import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_keeper_app/controller/noteController.dart';
import 'package:note_keeper_app/model/noteModel.dart';

class ActionController {
  final NoteController noteController = Get.put(NoteController());

  void deleteNoteDialog(BuildContext context, int noteId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await noteController.deleteNote(noteId);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void editNoteDialog(BuildContext context, Note note) {
    TextEditingController titleController =
        TextEditingController(text: note.title);
    TextEditingController descriptionController =
        TextEditingController(text: note.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: Container(
            height: 200,
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Note updatedNote = Note(
                  title: titleController.text,
                  description: descriptionController.text,
                );
                await noteController.updateNoteList();
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void addNoteDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Note'),
          content: Container(
            height: 200,
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (titleController.text.trim() != '') {
                  Note newNote = Note(
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                  );
                  await noteController.addNote(newNote);
                }

                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
