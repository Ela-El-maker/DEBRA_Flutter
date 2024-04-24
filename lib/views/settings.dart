import 'package:flutter/material.dart';

void main() {
  runApp(const MynotesApp());
}

class MynotesApp extends StatelessWidget {
  const MynotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('APP SETTINGS'),
        foregroundColor: Colors.pink[200],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Account Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountSettingsScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Theme Preferences'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThemePreferencesScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Account Settings'),
        foregroundColor: Colors.pink[200],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Change Password'),
            onTap: () {
              // Navigate to Change Password screen
               Navigator.pushNamed(context, '/changepassword');
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              Navigator.pushNamed(context, '/');
              // Perform logout action
            },
          ),
        ],
      ),
    );
  }
}

class ThemePreferencesScreen extends StatefulWidget {
  const ThemePreferencesScreen({super.key});

  @override
  _ThemePreferencesScreenState createState() => _ThemePreferencesScreenState();
}

class _ThemePreferencesScreenState extends State<ThemePreferencesScreen> {
  String selectedTheme = 'light';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Theme Settings'),
        foregroundColor: Colors.pink[200],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          RadioListTile<String>(
            title: const Text('Light Theme'),
            value: 'light',
            groupValue: selectedTheme,
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  selectedTheme = value;
                });
              }
            },
          ),
          RadioListTile<String>(
            title: const Text('Dark Theme'),
            value: 'dark',
            groupValue: selectedTheme,
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  selectedTheme = value;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
