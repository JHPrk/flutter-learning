import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_timer_example_001/ball.dart';
import 'package:flame_timer_example_001/vector_utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: BouncingExample()));
}

class BouncingExample extends FlameGame with HasCollisionDetection {
  late final TimerComponent bouncingGameTimer;
  int elapsedTime = 0;
  final Set<int> ballCollisionSet = {};
  final double ballSize = 16.0;
  final int endTimer = 10;
  final TextPaint defaultTextPaint =
      TextPaint(style: const TextStyle(color: Colors.white, fontSize: 16));

  @override
  FutureOr<void> onLoad() {
    bouncingGameTimer = TimerComponent(
        period: 1,
        onTick: () {
          add(Ball(
              position: VectorUtils.generateRandomPosition(
                  boundary: size, margin: Vector2.all(ballSize * 2)),
              radius: ballSize));

          if (++elapsedTime > endTimer) {
            bouncingGameTimer.timer.stop();
            remove(bouncingGameTimer);
          }
        },
        removeOnFinish: true,
        repeat: true);

    add(bouncingGameTimer);

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    defaultTextPaint.render(canvas,
        "Ball Counts : ${children.query<Ball>().length}", Vector2(10, 20));
    defaultTextPaint.render(
        canvas, "Time Elapsed : $elapsedTime", Vector2(10, 40));
  }
}
