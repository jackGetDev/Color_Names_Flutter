import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'color_model.dart';
import 'color_provider.dart';
import 'dark_mode_provider.dart';

class ColorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'COLOR NAMES',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.green,
        actions: [
          Consumer<DarkModeProvider>(
            builder: (context, darkModeProvider, _) => Row(
              children: [
                Icon(
                  Icons.wb_sunny,
                  color: darkModeProvider.isDarkMode ? Colors.grey : Colors.yellow,
                ),
                Switch(
                  value: darkModeProvider.isDarkMode,
                  onChanged: (value) {
                    darkModeProvider.toggleDarkMode();
                  },
                  activeTrackColor: Colors.grey.shade300,
                  activeColor: Colors.white,
                ),
                Icon(
                  Icons.nights_stay,
                  color: darkModeProvider.isDarkMode ? Colors.indigo : Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Consumer<ColorProvider>(
        builder: (context, colorProvider, child) {
          return GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _getCrossAxisCount(context),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: colorProvider.colors.length,
            itemBuilder: (context, index) {
              ColorModel color = colorProvider.colors[index];
              Color backgroundColor = Color(int.parse(color.color.substring(1, 7), radix: 16) + 0xFF000000);
              Color textColor = _getTextColorOnBackground(backgroundColor);

              return Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: ListTile(
                      title: Text(
                        color.name,
                        style: TextStyle(
                          color: textColor,
                          fontSize: _getFontSize(context),
                        ),
                      ),
                      subtitle: Text(
                        color.color,
                        style: TextStyle(
                          color: textColor,
                          fontSize: _getFontSize(context),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _getTextColorOnBackground(Color backgroundColor) {
    final luminance = (0.299 * backgroundColor.red +
            0.587 * backgroundColor.green +
            0.114 * backgroundColor.blue) /
        255;
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return 2; // Mobile size
    } else if (screenWidth < 1200) {
      return 4; // Medium size
    } else {
      return 8; // Full desktop
    }
  }

  double _getFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return 14; // Mobile size
    } else if (screenWidth < 1200) {
      return 16; // Medium size
    } else {
      return 18; // Full desktop
    }
  }
}
