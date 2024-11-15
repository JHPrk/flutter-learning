import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

void main() {
  var circles = Circles();
  runApp(GameWidget(game: circles));
}

class Circles extends FlameGame with HasCollisionDetection, TapDetector {
  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    add(ScreenHitbox());
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownInfo info) {
    var tapPosition = info.eventPosition.global;
    add(MyCollidables(position: tapPosition));
    super.onTapDown(info);
  }
}

class MyCollidables extends PositionComponent
    with CollisionCallbacks, HasGameRef<Circles> {
  Vector2 velocity = Vector2(0, 1);
  late final Color _collisionColor;
  late final Color _defaultColor;
  Color _currentColor;
  bool _isHitWall = false;
  bool _isCollision = false;
  late final double _speed;

  MyCollidables(
      {required Vector2 position,
      Color collisionColor = Colors.amber,
      Color defaultColor = Colors.cyan,
      double speed = 150.0})
      : _collisionColor = collisionColor,
        _defaultColor = defaultColor,
        _speed = speed,
        _currentColor = defaultColor,
        super(
            position: position, size: Vector2.all(16), anchor: Anchor.center) {
    add(CircleHitbox());
    // PolygonHitbox.relative(
    //     [Vector2(0, 1), Vector2(1, 0), Vector2(0, -1), Vector2(-1, 0)],
    //     parentSize: size)
  }

  @override
  FutureOr<void> onLoad() {
    var center = game.size / 2;
    velocity = (center - position).normalized() * -1;
    velocity.scaleTo(_speed);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_isHitWall) {
      // removeFromParent();
      // isHitWall = false;
      //velocity.reflect(Vector2(0, 1));
    } else {
      _currentColor = _isCollision ? _collisionColor : _defaultColor;
      // _isCollision = false;
    }
    position.add(velocity * dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final localCenter = (scaledSize / 2).toOffset();
    canvas.drawCircle(localCenter, size.x / 2, Paint()..color = _currentColor);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is ScreenHitbox) {
      _isHitWall = true;
      if (intersectionPoints.first.x >= game.size.x ||
          intersectionPoints.first.x <= 0) {
        velocity.x *= -1;
      }
      if (intersectionPoints.first.y >= game.size.y ||
          intersectionPoints.first.y <= 0) {
        velocity.y *= -1;
      }
    } else if (other is MyCollidables) {
      velocity *= -1;
      _isCollision = true;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is ScreenHitbox) {
      _isHitWall = false;
      if (other.position.x < 0 ||
          other.position.x > game.size.x ||
          other.position.y < 0 ||
          other.position.y > game.size.y) {
        velocity = (center - position).normalized() * -1
          ..scaled(_speed);
      }
    } else if (other is MyCollidables) {
      _isCollision = false;
    }
  }
}
