import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_keeper_app/controller/actionController.dart';
import 'package:note_keeper_app/controller/noteController.dart';
import 'package:note_keeper_app/model/noteModel.dart';

class HomePage extends StatelessWidget {
  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    noteController.updateNoteList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Keeper'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (noteController.noteList.isEmpty) {
                return Center(
                  child: Text('No notes available'),
                );
              } else {
                return ListView.builder(
                  itemCount: noteController.noteList.length,
                  itemBuilder: (context, index) {
                    Note note = noteController.noteList[index];
                    return Card(
                      child: ListTile(
                        title: Text(note.title!),
                        subtitle: Text(note.description!),
                        onTap: () {
                          ActionController().editNoteDialog(context, note);
                        },
                        onLongPress: () {
                          ActionController()
                              .deleteNoteDialog(context, note.id!);
                        },
                      ),
                    ).marginAll(10);
                  },
                );
              }
            }),
          ),
          ElevatedButton(
            onPressed: () {
              ActionController().addNoteDialog(context);
            },
            child: Text('Add Note'),
          ),
        ],
      ),
    );
  }
}
