import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flame_joystick_001/bullet.dart';
import 'package:flame_joystick_001/joystick_player.dart';
import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';

void main() {
  runApp(GameWidget(game: JoystickExample()));
}

class JoystickExample extends FlameGame with DragCallbacks, TapDetector {
  late final JoystickComponent joystick;
  late final JoystickPlayer player;
  final TextPaint joystickRadianTextPaint = TextPaint(
      style: const TextStyle(
          fontSize: 14, fontFamily: 'AwesomeFont', color: Colors.white));
  final TextPaint bulletsCounterTextPaint = TextPaint(
      style: const TextStyle(
          fontSize: 14, fontFamily: 'AwesomeFont', color: Colors.white));

  final _parallaxImgPaths = ["big_stars.png", "small_stars.png"];
  late final ParallaxComponent parallaxComponent;
  final double _parallaxSpeed = 50.0;

  @override
  FutureOr<void> onLoad() async {
    var knobPaint = BasicPalette.green.withAlpha(100).paint();
    var backgroundPaint = BasicPalette.green.withAlpha(200).paint();
    joystick = JoystickComponent(
        knob: CircleComponent(radius: 15, paint: knobPaint),
        background: CircleComponent(radius: 50, paint: backgroundPaint),
        margin: const EdgeInsets.only(left: 20, bottom: 40));

    player = JoystickPlayer(joystick, size: Vector2.all(50));

    add(joystick);
    add(player);

    await FlameAudio.audioCache.loadAll([
      "laser_004.wav",
      "missile_flyby.wav",
      "missile_hit.wav",
      "missile_shot.wav"
    ]);

    bgmPlay();

    // Parallax
    parallaxComponent = await loadParallaxComponent(
        _parallaxImgPaths.map((e) => ParallaxImageData(e)),
        baseVelocity: Vector2(0, -_parallaxSpeed),
        velocityMultiplierDelta: Vector2(1.0, 2.0),
        repeat: ImageRepeat.repeat);

    add(parallaxComponent);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    Vector2 velocity = Vector2(0, -1);
    velocity.rotate(player.angle); // Angle만
    parallaxComponent.parallax?.baseVelocity = player.currentVelocity;
  }

  @override
  void onTapDown(TapDownInfo info) {
    var velocity = Vector2(0, -1);
    velocity.rotate(player.angle);
    add(Bullet(player.position, velocity));
    super.onTapDown(info);
  }

  @override
  void render(Canvas canvas) {
    joystickRadianTextPaint.render(canvas,
        '${player.angle.toStringAsFixed(5)} Radians', Vector2(20, size.y - 24));
    joystickRadianTextPaint.render(canvas,
        'Bullets : ${children.query<Bullet>().length}', Vector2(20, 20));
    super.render(canvas);
  }

  void bgmPlay() {
    FlameAudio.bgm.initialize();
    //FlameAudio.bgm.play("race_to_mars.mp3");
  }
}
