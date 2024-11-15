import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:flame_timer_example_001/main.dart';
import 'package:flame_timer_example_001/life_info.dart';
import 'package:flame_timer_example_001/vector_utils.dart';
import 'package:flutter/material.dart';

class Ball extends PositionComponent
    with CollisionCallbacks, HasGameRef<BouncingExample> {
  late final LifeInfo lifeInfo;
  late final double radius;
  late final double maxSpeed;
  late final double minSpeed;
  late final Offset _centerOffset;
  late Vector2 velocity;
  Paint circlePaint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill;

  bool _isCollision = false;

  Ball(
      {this.radius = 16,
      super.position,
      this.maxSpeed = 400,
      this.minSpeed = 100,
      super.anchor = Anchor.center})
      : super(size: Vector2.all(radius * 2));

  @override
  FutureOr<void> onLoad() {
    _centerOffset = (scaledSize / 2).toOffset();
    lifeInfo = LifeInfo(life: 10);
    velocity = VectorUtils.generateRandomVelocity();
    add(lifeInfo);
    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(velocity * dt);
    circlePaint.color = _isCollision ? Colors.orange : Colors.blue;

    if (VectorUtils.bouncingFromScreen(position, game.size, velocity,
        margin: size)) {
      lifeInfo.decreaseLife();
    }
    if (lifeInfo.isDead()) {
      removeFromParent();
    }
    if (_isCollision) {
      lifeInfo.decreaseLife();
      velocity.negate();
      _isCollision = false;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(_centerOffset, radius, circlePaint);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Ball) {
      _isCollision = true;
      if (!game.ballCollisionSet.contains(hashCode) ||
          !game.ballCollisionSet.contains(other.hashCode)) {
        print("hello from : $hashCode to ${other.hashCode}");
      }
      game.ballCollisionSet.add(other.hashCode);
      game.ballCollisionSet.add(hashCode);
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Ball) {
      _isCollision = false;
      game.ballCollisionSet.remove(hashCode);
      game.ballCollisionSet.remove(other.hashCode);
    }
  }
}
