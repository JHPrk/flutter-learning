import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/particles.dart';
import 'package:flame/sprite.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:flutter/material.dart';

import 'package:flame_particle_example_001/utils.dart';

void main() {
  runApp(GameWidget(game: ParticleSystemExample001()));
}

class ParticleSystemExample001 extends FlameGame
    with
        PanDetector,
        TapDetector,
        DoubleTapDetector,
        LongPressDetector,
        SecondaryTapDetector {
  @override
  FutureOr<void> onLoad() async {
    await images.load('boom.png');
    return super.onLoad();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    add(ParticleGenerator.createSimpleParticleEngine(
        position: info.eventPosition.global));
    super.onPanUpdate(info);
  }

  @override
  void onTapUp(TapUpInfo info) {
    super.onTapUp(info);
    add(ParticleGenerator.createExplosionParticleEngine(
        position: info.eventPosition.global, count: 40));
  }

  @override
  void onDoubleTapDown(TapDownInfo info) {
    super.onDoubleTapDown(info);
    add(ParticleGenerator.createFireworkParticleEngine(
        position: info.eventPosition.global));
  }

  @override
  void onSecondaryTapUp(TapUpInfo info) {
    super.onSecondaryTapUp(info);
    var boomImage = images.fromCache('boom.png');
    add(ParticleGenerator.createExplosionSpriteSheetAnimation(
        position: info.eventPosition.global,
        spriteSheetImage: boomImage,
        size: 100));
  }

  @override
  void onLongPressStart(LongPressStartInfo info) {
    super.onLongPressStart(info);

    var boomImage = images.fromCache('boom.png');
    add(ParticleGenerator.createExplosionSpriteSheetAnimation(
        position: info.eventPosition.global,
        spriteSheetImage: boomImage,
        size: 150));
  }
}

class ParticleGenerator {
  static final Random _random = Random();

  static final List<Paint> _fireworkPaints = [
    Colors.amber,
    Colors.amberAccent,
    Colors.red,
    Colors.redAccent,
    Colors.yellow,
    Colors.yellowAccent
  ].map((color) => Paint()..color = color).toList();

  static Paint chooseRandomPaint() {
    return randomElement(_fireworkPaints);
  }

  static T randomElement<T>(List<T> list) {
    return list[_random.nextInt(list.length)];
  }

  static ParticleSystemComponent createSimpleParticleEngine(
      {required Vector2 position}) {
    return ParticleSystemComponent(
        particle: AcceleratedParticle(
      lifespan: 0.5,
      position: position,
      speed: Vector2(_random.nextDouble() * 400 - 200,
          max(_random.nextDouble(), 0.1) * 200),
      child: CircleParticle(
          radius: 1.0,
          paint: Paint()
            ..color =
                Color.lerp(Colors.yellow, Colors.red, _random.nextDouble())!),
    ));
  }

  static ParticleSystemComponent createExplosionParticleEngine(
      {required Vector2 position, int count = 40}) {
    return ParticleSystemComponent(
        particle: Particle.generate(
            count: count,
            lifespan: 2,
            generator: (i) => AcceleratedParticle(
                position: position.clone(),
                acceleration: Utils.generateRandomVector().scaled(200),
                child: CircleParticle(
                    radius: 1, paint: Paint()..color = Colors.red))));
  }

  static ParticleSystemComponent createFireworkParticleEngine(
      {required Vector2 position}) {
    return ParticleSystemComponent(
        particle: Particle.generate(
            count: 30,
            lifespan: 2,
            generator: (i) {
              var initialSpeed = Utils.generateRandomVector().scaled(200);
              var decceleration = -initialSpeed;
              var gravity = Vector2(0, 40);
              return AcceleratedParticle(
                  position: position.clone(),
                  speed: initialSpeed,
                  acceleration: decceleration + gravity,
                  child: ComputedParticle(
                    renderer: (canvas, particle) {
                      final paint = chooseRandomPaint();
                      paint.color =
                          paint.color.withOpacity(1 - particle.progress);

                      canvas.drawCircle(
                          Offset.zero,
                          _random.nextDouble() * particle.progress > 0.6
                              ? (50 * particle.progress)
                              : (2 + 3 * particle.progress),
                          paint);
                    },
                  ));
            }));
  }

  static ParticleSystemComponent createExplosionSpriteSheetAnimation(
      {required Vector2 position,
      double size = 128,
      required final spriteSheetImage}) {
    var newSize = Vector2.all(size);
    var newPos = position.clone();
    newPos.sub(Vector2(0, size / 4));
    return ParticleSystemComponent(
        particle: AcceleratedParticle(
            lifespan: 1,
            position: newPos,
            child: SpriteAnimationParticle(
                animation: _getBoomAnimation(spriteSheetImage),
                size: newSize)));
  }

  static SpriteAnimation _getBoomAnimation(final spriteSheetImage) {
    const columns = 8;
    const rows = 8;
    const frames = columns * rows;
    final spriteSheet = SpriteSheet.fromColumnsAndRows(
        image: spriteSheetImage, columns: columns, rows: rows);
    final sprites = List<Sprite>.generate(frames, spriteSheet.getSpriteById);
    return SpriteAnimation.spriteList(sprites, stepTime: 0.1);
  }

  static createGroundExplosion({required Vector2 position}) {}
}
