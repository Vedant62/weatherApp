import 'package:flutter/material.dart';
import 'package:weather_app/weather_screen.dart';

void main() {
  runApp(MyApp(initialThemeMode: ThemeMode.dark));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.initialThemeMode}) : super(key: key);

  final ThemeMode initialThemeMode;

  static void changeThemeMode(BuildContext context, ThemeMode themeMode) {
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state._setThemeMode(themeMode);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _setThemeMode(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _themeMode,
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}
