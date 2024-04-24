import 'package:flutter/material.dart';
import 'package:flutter_application_1/pag/home.dart';

class EditNoteScreen extends StatelessWidget {
  final Note note;
  final TextEditingController contentController;

  EditNoteScreen({Key? key, required this.note})
      : contentController = TextEditingController(text: note.content),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
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
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final editedNote = Note(
                  title: note.title,
                  content: contentController.text,
                  folder: note.folder,
                );
                // Return the edited note to the previous screen
                Navigator.pop(context, editedNote);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
