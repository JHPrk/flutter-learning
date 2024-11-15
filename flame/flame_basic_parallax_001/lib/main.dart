import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  var basicParallaxExample001 = BasicParallaxExample001();
  var basicParallaxExample002 = BasicParallaxExample002();
  runApp(GameWidget(
    game: basicParallaxExample001,
  ));
}

class BasicParallaxExample001 extends FlameGame {
  final _parallaxImgData = [
    ParallaxImageData("bg.png"),
    ParallaxImageData("foreground-trees.png"),
    ParallaxImageData("mountain-far.png"),
    ParallaxImageData("mountains.png"),
    ParallaxImageData("trees.png"),
  ];

  @override
  FutureOr<void> onLoad() async {
    final _parallaxImgs = [
      loadParallaxImage(
        "bg.png",
      ),
      loadParallaxImage("mountain-far.png"),
      loadParallaxImage("mountains.png"),
      loadParallaxImage("trees.png"),
      loadParallaxImage("foreground-trees.png"),
    ];
    final parallaxLayers = [
      ParallaxLayer(await _parallaxImgs[0],
          velocityMultiplier: Vector2(5.0, 1)),
      ParallaxLayer(await _parallaxImgs[1],
          velocityMultiplier: Vector2(-1.5, 1)),
      ParallaxLayer(await _parallaxImgs[2],
          velocityMultiplier: Vector2(0.5, 1)),
      ParallaxLayer(await _parallaxImgs[3],
          velocityMultiplier: Vector2(-2.0, 1)),
      ParallaxLayer(await _parallaxImgs[4],
          velocityMultiplier: Vector2(3.0, 1)),
    ];
    // final parallax = await loadParallaxComponent(_parallaxImgData,
    //     baseVelocity: Vector2(-10, 0),
    //     velocityMultiplierDelta: Vector2(1.8, 1));
    final parallaxComponent = ParallaxComponent(
        parallax: Parallax(parallaxLayers, baseVelocity: Vector2(30, 0)));

    add(parallaxComponent);
    return super.onLoad();
  }
}

class BasicParallaxExample002 extends FlameGame {
  final _parallaxImages = [
    ParallaxImageData("big_stars.png"),
    ParallaxImageData("small_stars.png"),
  ];

  @override
  FutureOr<void> onLoad() async {
    final parallaxComponent = await loadParallaxComponent(_parallaxImages,
        baseVelocity: Vector2(0, -5),
        velocityMultiplierDelta: Vector2(1.0, 1.8),
        repeat: ImageRepeat.repeat);
    add(parallaxComponent);
    return super.onLoad();
  }
}
