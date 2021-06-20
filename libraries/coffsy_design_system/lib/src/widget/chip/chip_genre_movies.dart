import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

Widget buildGenreChip(int id) {
  return Container(
    margin: EdgeInsets.only(right: 10),
    padding: EdgeInsets.all(8),
    child: Text(
      Genres.genres[id] ?? 'No Gender',
      style: TextStyle(fontSize: 12),
    ),
    decoration: BoxDecoration(
      border: Border.all(color: ColorPalettes.grey),
      borderRadius: BorderRadius.circular(20),
    ),
  );
}
