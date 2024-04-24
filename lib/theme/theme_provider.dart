import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'package:provider/provider.dart';

// Assume lightMode and darkMode are defined elsewhere

enum ThemeType { light, dark }

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode; // Default theme is light mode

  ThemeData getTheme() => _themeData;

  void setTheme(ThemeType themeType) {
    // You need to ensure lightMode and darkMode are properly defined
    _themeData = themeType == ThemeType.light ? lightMode : darkMode;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).getTheme(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Switcher'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThemePage()), // Navigate to ThemePage
            );
          },
          child: Text('Switch Theme'),
        ),
      ),
    );
  }
}

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Settings'),
      ),
      body: Center(
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return ElevatedButton(
              onPressed: () {
                themeProvider.setTheme(
                  themeProvider.getTheme() == lightMode ? ThemeType.dark : ThemeType.light,
                );
              },
              child: Text('Switch Theme'),
            );
          },
        ),
      ),
    );
  }
}
