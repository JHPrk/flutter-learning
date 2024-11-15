import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_asteroid_wrapup_001/objects/bullet/bullet.dart';
import 'package:flame_asteroid_wrapup_001/main.dart';
import 'package:flutter/material.dart';

class Spaceship extends SpriteComponent with HasGameRef<AsteroidGame> {
  final BulletEnum _bulletType = BulletEnum.slowBullet;

  double maxSpeed = 300.0;

  static final Paint _paint = Paint()..color = Colors.transparent;

  final RectangleComponent muzzleComponent =
      RectangleComponent(position: Vector2(1, 1), paint: _paint);

  final JoystickComponent joystick;

  Spaceship(this.joystick)
      : super(size: Vector2.all(35.0), anchor: Anchor.center);

  BulletEnum get getBulletEnum => _bulletType;

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite("asteroids_ship.png");
    position = gameRef.size / 2;
    muzzleComponent.position.x = size.x / 2;
    muzzleComponent.position.y = size.y / 10;

    add(muzzleComponent);
    return super.onLoad();
  }
}
