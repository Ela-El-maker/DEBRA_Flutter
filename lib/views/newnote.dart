import 'package:flutter/material.dart';
import 'package:flutter_application_1/pag/home.dart';

class CreateNoteScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Note'),
        foregroundColor: Colors.pink[200],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newNote = Note(
                  title: titleController.text,
                  content: contentController.text,
                  folder: Folder(name: 'Default', notes: []),
                );
                // Return the new note to the previous screen
                Navigator.pop(context, newNote);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
