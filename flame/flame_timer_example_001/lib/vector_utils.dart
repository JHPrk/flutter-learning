import 'dart:math';

import 'package:flame/game.dart';

class VectorUtils {
  VectorUtils._();
  static Random rand = Random();

  static Vector2 generateRandomDirection() {
    return Vector2(rand.nextDouble() * 2 - 1, rand.nextDouble() * 2 - 1)
        .normalized();
  }

  static Vector2 generateRandomVelocity(
      {int maxSpeed = 400, int minSpeed = 100}) {
    return generateRandomDirection()
        .scaled(rand.nextDouble() * (maxSpeed - minSpeed) + minSpeed);
  }

  static Vector2 generateRandomPosition(
      {required Vector2 boundary, Vector2? margin}) {
    margin = margin ?? Vector2.zero();
    return Vector2(rand.nextDouble() * (boundary.x - margin.x) + margin.x / 2,
        rand.nextDouble() * (boundary.y - margin.y) + margin.y / 2);
  }

  static bool bouncingFromScreen(
      Vector2 position, Vector2 screen, Vector2 velocity,
      {Vector2? margin}) {
    margin = margin ?? Vector2.zero();
    bool result = false;
    if (position.x < 0 + margin.x || position.x > screen.x - margin.x) {
      velocity.x *= -1;
      result = true;
    }
    if (position.y < 0 + margin.y || position.y > screen.y - margin.y) {
      velocity.y *= -1;
      result = true;
    }
    return result;
  }
}
