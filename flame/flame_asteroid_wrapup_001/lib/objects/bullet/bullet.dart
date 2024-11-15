import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

enum BulletEnum { fastBullet, slowBullet }

abstract class Bullet extends PositionComponent with CollisionCallbacks {
  static const double defaultSpeed = 100.0;
  static const int defaultHealth = 1;
  static const int defaultDamage = 1;

  late double _speed;
  late Vector2 _velocity;
  late int _health;
  late int _damage;

  int get health => _health;
  int get damage => _damage;

  Bullet({super.position, super.size, required Vector2 velocity})
      : _velocity = velocity.normalized(),
        _speed = defaultSpeed,
        _health = defaultHealth,
        _damage = defaultDamage;

  Bullet.fullInit(
      {super.position,
      super.size,
      required Vector2 velocity,
      double? speed,
      int? health,
      int? damage})
      : _velocity = velocity.normalized(),
        _speed = speed ?? defaultSpeed,
        _health = health ?? defaultHealth,
        _damage = damage ?? defaultDamage;

  void onCreate();
  void onDestroy();
  void onHit(PositionComponent other);
}

class FastBullet extends Bullet {
  static final _paint = Paint()..color = Colors.green;

  FastBullet({super.position, super.size, required super.velocity}) : super();

  FastBullet.fullInit(
      {super.position,
      super.size,
      required super.velocity,
      super.damage,
      super.health,
      super.speed})
      : super.fullInit();

  @override
  FutureOr<void> onLoad() {
    _velocity = _velocity.scaled(_speed);
    print("FastBullet onLoad called : speed = $_speed");
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(_velocity * dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void onCreate() {
    print("FastBullet onCreate called");
  }

  @override
  void onDestroy() {
    print("FastBullet onDestroy called");
  }

  @override
  void onHit(PositionComponent other) {
    print("FastBullet onHit called");
  }
}

class SlowBullet extends Bullet {
  static final _paint = Paint()..color = Colors.red;

  SlowBullet({super.position, super.size, required super.velocity}) : super();

  SlowBullet.fullInit(
      {super.position,
      super.size,
      required super.velocity,
      super.damage,
      super.health,
      super.speed})
      : super.fullInit();

  @override
  FutureOr<void> onLoad() {
    _velocity = _velocity.scaled(_speed);
    print("SlowBullet onLoad called : speed = $_speed");
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(_velocity * dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, _paint);
  }

  @override
  void onCreate() {
    print("SlowBullet onCreate called");
  }

  @override
  void onDestroy() {
    print("SlowBullet onDestroy called");
  }

  @override
  void onHit(PositionComponent other) {
    print("SlowBullet onHit called");
  }
}
