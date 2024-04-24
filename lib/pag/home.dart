import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/LoginController.dart';
import 'package:flutter_application_1/components/list_button.dart';
import 'package:flutter_application_1/components/list_data.dart';
import 'package:flutter_application_1/views/editnote.dart';
import 'package:flutter_application_1/views/login.dart';
import 'package:flutter_application_1/views/newnote.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NOTEPAD APP',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const Dashboard(),
    );
  }
}

LoginController loginController = Get.put(LoginController());

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    NotesList(),
    Favorites(),
    ProfileT(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('${loginController.username.value}'),
        foregroundColor: Colors.pink[200],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/Notes icon.jpeg',
                    height: 80,
                    width: 80,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'NOTE',
                    style: TextStyle(
                      color: Color.fromARGB(255, 244, 108, 154),
                      fontSize: 24,
                    ),
                  ),
                  // Text(
                  //   '${loginController.username.value}',
                  //   style: TextStyle(
                  //     color: Color.fromARGB(255, 244, 108, 154),
                  //     fontSize: 24,
                  //   ),
                  // ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to the home screen or perform any action
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
                // Navigate to the settings screen or perform any action
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/notepad background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: _tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class Folder {
  final String name;
  final List<Note> notes;

  Folder({required this.name, required this.notes});
}

class Note {
  final String title;
  final String content;
  final Folder folder;

  Note({
    required this.title,
    required this.content,
    required this.folder,
  });
}

class NotesList extends StatefulWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  List<Folder> folders = [
    Folder(name: 'Folder 1', notes: []),
    Folder(name: 'Folder 2', notes: []),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/notepad_background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Show list of folders
              Expanded(
                child: ListView.builder(
                  itemCount: folders.length,
                  itemBuilder: (context, index) {
                    return NotepadCard(
                      title: folders[index].name,
                      count: folders[index].notes.length,
                      onTap: () {
                        _viewFolderNotes(folders[index]);
                      },
                      onAddNote: () {
                        _addNoteToFolder(index);
                      },
                      onDeleteFolder: () {
                        _deleteFolder(index);
                      },
                    );
                  },
                ),
              ),
              FloatingActionButton(
                onPressed: () async {
                  // Navigate to the screen for creating a new folder
                  final newFolderName = await showDialog<String>(
                    context: context,
                    builder: (context) => _buildAddFolderDialog(context),
                  );
                  if (newFolderName != null && newFolderName.isNotEmpty) {
                    setState(() {
                      folders.add(Folder(name: newFolderName, notes: []));
                    });
                  }
                },
                child: const Icon(Icons.add),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddFolderDialog(BuildContext context) {
    TextEditingController folderNameController = TextEditingController();

    return AlertDialog(
      title: Text('Add Folder'),
      content: TextField(
        controller: folderNameController,
        decoration: InputDecoration(labelText: 'Folder Name'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            String folderName = folderNameController.text.trim();
            if (folderName.isNotEmpty) {
              Navigator.pop(context, folderName);
            } else {
              // Show an error message if the folder name is empty
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Folder name cannot be empty.'),
                duration: Duration(seconds: 2),
              ));
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }

  void _addNoteToFolder(int folderIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateNoteScreen(folder: folders[folderIndex]),
      ),
    ).then((newNote) {
      if (newNote != null) {
        setState(() {
          folders[folderIndex].notes.add(newNote);
        });
      }
    });
  }

  void _viewFolderNotes(Folder folder) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FolderNotesScreen(folder: folder),
      ),
    );
  }

  void _deleteFolder(int folderIndex) {
    setState(() {
      folders.removeAt(folderIndex);
    });
  }
}

class NotepadCard extends StatelessWidget {
  final String title;
  final int count;
  final VoidCallback onTap;
  final VoidCallback? onAddNote;
  final VoidCallback? onDeleteFolder;

  const NotepadCard({
    required this.title,
    required this.count,
    required this.onTap,
    this.onAddNote,
    this.onDeleteFolder,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(
                          255, 244, 108, 154), // Set font color to pink
                    ),
                  ),
                  Row(
                    children: [
                      if (onAddNote != null)
                        IconButton(
                          onPressed: onAddNote,
                          icon: Icon(Icons.add),
                          tooltip: 'Add Note',
                        ),
                      if (onDeleteFolder != null)
                        IconButton(
                          onPressed: onDeleteFolder,
                          icon: Icon(Icons.delete),
                          tooltip: 'Delete Folder',
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                'Total Notes: $count',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color.fromARGB(
                      255, 244, 108, 154), // Set font color to pink
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateNoteScreen extends StatelessWidget {
  final Folder folder;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  CreateNoteScreen({Key? key, required this.folder}) : super(key: key);

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
                  folder: folder,
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

class FolderNotesScreen extends StatelessWidget {
  final Folder folder;

  FolderNotesScreen({Key? key, required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(folder.name),
        foregroundColor: Colors.pink[200],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: folder.notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(folder.notes[index].title),
            subtitle: Text(folder.notes[index].content),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editNote(context, folder.notes[index]);
              },
            ),
          );
        },
      ),
    );
  }

  void _editNote(BuildContext context, Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNoteScreen(note: note),
      ),
    ).then((editedNote) {
      if (editedNote != null) {
        // Update the note in the folder
        int noteIndex =
            folder.notes.indexWhere((n) => n.title == editedNote.title);
        if (noteIndex != -1) {
          folder.notes[noteIndex] = editedNote;
        }
      }
    });
  }
}

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

// Function to add a new folder
Future<void> addFolder(String folderName) async {
  try {
    final response = await http.post(
      Uri.parse('http://acs314flutter.xyz/acs314_debra/Notes/notes.php'),
      body: {
        'action': 'addFolder', // Action to indicate adding a folder
        'folderName': folderName,
      },
    );

    if (response.statusCode == 200) {
      // Folder added successfully, handle accordingly
      print('Folder added successfully');
    } else {
      // Handle error
      print('Failed to add folder: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exception
    print('Exception while adding folder: $e');
  }
}

// Function to add a new note to a folder
Future<void> addNoteToFolder(
    String folderId, String title, String content) async {
  try {
    final response = await http.post(
      Uri.parse('http://acs314flutter.xyz/acs314_debra/Notes/notes.php'),
      body: {
        'action': 'addNote', // Action to indicate adding a note
        'folderId': folderId,
        'title': title,
        'content': content,
      },
    );

    if (response.statusCode == 200) {
      // Note added successfully, handle accordingly
      print('Note added successfully');
    } else {
      // Handle error
      print('Failed to add note: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exception
    print('Exception while adding note: $e');
  }
}

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Favorites'),
    );
  }
}

class ProfileT extends StatefulWidget {
  const ProfileT({super.key});

  @override
  State<ProfileT> createState() => _ProfileTState();
}

class _ProfileTState extends State<ProfileT> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/personicon.png'),
            ),
            const SizedBox(height: 10),
            Text(
              '${loginController.username.value}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 244, 108, 154),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${loginController.email.value}',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 244, 108, 154),
              ),
            ),
            SizedBox(height: 20),
            _buildProfileCard('Email', '${loginController.email.value}'),
            _buildProfileCard('username', '${loginController.username.value}'),
            _buildProfileCard(
                'Bio', 'Passionate about note-taking and organizing thoughts.'),
            _buildProfileCard('Location', 'Nairobi, Kenya'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
                // Handle logout or navigate to a logout screen
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(String title, String content) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(content),
      ),
    );
  }
}
// class Profile extends StatelessWidget {
//   @override
  

// }
