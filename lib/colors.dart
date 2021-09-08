import 'package:flutter/material.dart';

List rgbs = [
  [0, 161, 157],
  [255, 248, 229],
  [255, 179, 68],
  [224, 93, 93],
];
MaterialColor ctmMaterialColor(key) {
  List prim = ["0xFF00A19D", "0xFFF8E5FE", "0xFFFFB344", "0xFFE05D5D"];
  Map customColors = {};
  for (int i = 0; i < rgbs.length; i++) {
    Map<int, Color> colorShads = {};
    for (int n = 1; n < 11; n++) {
      if (n == 1) {
        colorShads[50] = Color.fromRGBO(rgbs[i][0], rgbs[i][1], rgbs[i][2], .1);
      } else {
        colorShads[100 * (n - 1)] =
            Color.fromRGBO(rgbs[i][0], rgbs[i][1], rgbs[i][2], n / 10);
      }
      customColors[i] = MaterialColor(int.parse(prim[i]), colorShads);
    }
  }

  return customColors[key];
}

Color ctmColor(key) {
  Map colors = {};
  for (int i = 0; i < rgbs.length; i++) {
    colors[i] = Color.fromARGB(255, rgbs[i][0], rgbs[i][1], rgbs[i][2]);
  }
  return colors[key];
}
