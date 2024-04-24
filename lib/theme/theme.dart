import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ThemeType { light, dark }

class ThemeProvider extends ChangeNotifier {
  ThemeData _lightTheme = lightMode; // Use lightMode instead of lightMode
  ThemeData _darkTheme = darkMode; // Use darkMode instead of DarkMode

  ThemeData getTheme(ThemeType themeType) =>
      themeType == ThemeType.light ? _lightTheme : _darkTheme;

  void setTheme(ThemeType themeType) {
    _lightTheme = lightMode; // Assign lightMode to _lightTheme
    _darkTheme = darkMode; // Assign darkMode to _darkTheme
    notifyListeners();
  }
}

// Define lightMode and darkMode here

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    onPrimary: Colors.grey.shade800, // Use onPrimary instead of inversePrimary
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    onPrimary: Colors.grey.shade300, // Use onPrimary instead of inversePrimary
  ),
);

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
      theme: Provider.of<ThemeProvider>(context).getTheme(ThemeType.light), // Use light theme initially
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
            var themeProvider = Provider.of<ThemeProvider>(context, listen: false);
            themeProvider.setTheme(
              themeProvider.getTheme(ThemeType.light) == lightMode
                  ? ThemeType.dark
                  : ThemeType.light,
            );
          },
          child: Text('Switch Theme'),
        ),
      ),
    );
  }
}
