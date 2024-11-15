import 'package:flame/game.dart';

class Utils {
  Utils._();

  static bool isOutOfBoundary(Vector2 position, Vector2 screenSize,
      {Vector2? objectSize}) {
    objectSize = objectSize ?? Vector2.all(0);
    return (position.x < 0 - objectSize.x ||
        position.x > screenSize.x + objectSize.x ||
        position.y < 0 - objectSize.y ||
        position.y > screenSize.y + objectSize.y);
  }

  static Vector2 adjustOjbectOutsideScreen(Vector2 position, Vector2 screenSize,
      {Vector2? objectSize}) {
    if (position.x < 0) position.x = screenSize.x;
    if (position.x > screenSize.x) position.x = 0;
    if (position.y < 0) position.y = screenSize.y;
    if (position.y < 0) position.y = 0;
    return position;
  }
}
