import 'package:flutter/material.dart';

import 'color_model.dart';

class ColorProvider extends ChangeNotifier {
  List<ColorModel> colors;

  ColorProvider({required this.colors});
}
