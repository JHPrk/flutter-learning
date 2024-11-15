import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class LifeInfo extends TextComponent {
  final TextPaint lifeTextPaint = TextPaint(
      style: const TextStyle(
          color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600));

  late double life;

  LifeInfo({this.life = 10, super.position});

  @override
  FutureOr<void> onLoad() {
    textRenderer = lifeTextPaint;
    position = Vector2(10 - size.x, -size.y);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    text = "$life";
    super.update(dt);
  }

  bool isDead() => life <= 0;

  void decreaseLife() => life--;
}
