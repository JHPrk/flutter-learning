import 'dart:math';

import 'package:flame/components.dart';

class Utils {
  Utils._();
  static Random random = Random();

  static Vector2 generateRandomVector() {
    var randomVector =
        Vector2(random.nextDouble() * 2 - 1, random.nextDouble() * 2 - 1);
    return randomVector;
  }
}
