import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_asteroid_wrapup_001/command/command.dart';
import 'package:flame_asteroid_wrapup_001/command/controller.dart';
import 'package:flame_asteroid_wrapup_001/spaceship.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: AsteroidGame()));
}

class AsteroidGame extends FlameGame with HasCollisionDetection, TapDetector {
  late Spaceship player;
  late Controller controller;

  @override
  FutureOr<void> onLoad() {
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

  @override
  void onTapUp(TapUpInfo info) {
    super.onTapUp(info);
    controller.addCommand(UserTapCommand(player));
  }
}
