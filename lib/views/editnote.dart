import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/editexisting.dart' as EditExisting; // Import with prefix
import 'package:flutter_application_1/pag/home.dart';

class NoteDetailScreen extends StatelessWidget {
  final Note note;
  final Function onDelete;

  const NoteDetailScreen({Key? key, required this.note,required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        foregroundColor: Colors.pink[200],
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // Call the onDelete function when delete button is pressed
              onDelete();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.content,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the screen for editing the note
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditExisting.EditNoteScreen(note: note), // Using prefix to refer to EditNoteScreen
                  ),
                );
              },
              child: Text('Edit Note'),
            ),
          ],
        ),
      ),
    );
  }
}
