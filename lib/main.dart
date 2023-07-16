import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'color_model.dart';
import 'color_provider.dart';
import 'dark_mode_provider.dart';
import 'color_screen_page.dart';
void main() async {
  // Load JSON data
  WidgetsFlutterBinding.ensureInitialized();
  String jsonData = await rootBundle.loadString('assets/color_names.json');
  List<dynamic> colorData = json.decode(jsonData);

  // Convert JSON data to ColorModel objects
  List<ColorModel> colors = colorData
      .map((data) => ColorModel(name: data['name'], color: data['color']))
      .toList();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkModeProvider>(
          create: (_) => DarkModeProvider(),
        ),
        ChangeNotifierProvider<ColorProvider>(
          create: (_) => ColorProvider(colors: colors),
        ),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Color Names',
      theme: _getThemeData(context),
      home: Consumer<DarkModeProvider>(
        builder: (context, darkModeProvider, _) {
          return ColorScreen();
        },
      ),
    );
  }

  ThemeData _getThemeData(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeProvider>(context);
    final isDarkMode = darkModeProvider.isDarkMode;

    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      // You can customize other theme properties based on dark mode or light mode here
    );
  }
}
