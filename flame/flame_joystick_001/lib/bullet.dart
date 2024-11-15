import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_joystick_001/main.dart';
import 'package:flame_joystick_001/utils.dart';
import 'package:flutter/material.dart';

class Bullet extends PositionComponent with HasGameRef<JoystickExample> {
  final double _speed = 150.0;
  late final Vector2 _velocity;
  static final _bulletPaint = Paint()..color = Colors.white;

  Bullet(Vector2 position, Vector2 velocity)
      : _velocity = velocity,
        super(position: position, size: Vector2.all(2), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    _velocity.scale(_speed);
    // FlameAudio.play("laser_004.wav");
    // FlameAudio.play("missile_flyby.wav");
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(_velocity * dt);
    if (Utils.isOutOfBoundary(position, game.size, objectSize: size)) {
      //FlameAudio.play("missile_hit.wav");
      game.remove(this);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), _bulletPaint);
  }
}
