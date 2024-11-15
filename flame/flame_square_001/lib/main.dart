// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: ComponentExample001()));
}

enum Placement { LEFT, RIGHT, CENTER }

class LifeBar extends PositionComponent {
  double currentLife = 100.0;
  final Color _healthyColor;
  final Color _warningColor;
  final double _warningTheshold;
  final Size _parentSize;
  final Placement _placement;
  final double _barOffset;
  List<RectangleComponent> lifeBarElements =
      List.filled(3, RectangleComponent(size: Vector2(1, 1)), growable: false);

  LifeBar({
    this.currentLife = 100.0,
    Color healthyColor = Colors.green,
    Color warningColor = Colors.red,
    double warningTheshold = 25.0,
    required Size parentSize,
    Placement placement = Placement.LEFT,
    double barOffset = 2.0,
    super.size,
  })  : _healthyColor = healthyColor,
        _warningColor = warningColor,
        _warningTheshold = warningTheshold,
        _parentSize = parentSize,
        _placement = placement,
        _barOffset = barOffset;

  Color get currentColor =>
      currentLife <= _warningTheshold ? _warningColor : _healthyColor;

  @override
  FutureOr<void> onLoad() {
    size.setValues(
        size.x > 0 ? size.x : _parentSize.width, size.y > 0 ? size.y : 5);
    createHealthBar();
    return super.onLoad();
  }

  void createHealthBar() {
    var outlineColorPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    var backgroundColorPaint = Paint()
      ..color = Colors.grey.withOpacity(0.35)
      ..style = PaintingStyle.fill;
    var healthColorPaint = Paint()
      ..color = currentColor
      ..style = PaintingStyle.fill;

    var lifebarPosition = _generateLifebarPosition();

    lifeBarElements = [
      RectangleComponent(
          position: lifebarPosition,
          paint: outlineColorPaint,
          size: size,
          angle: 0),
      RectangleComponent(
          position: lifebarPosition,
          paint: backgroundColorPaint,
          size: size,
          angle: 0),
      RectangleComponent(
          position: lifebarPosition,
          paint: healthColorPaint,
          size: Vector2(calcLifebarWidthWithCurrnetHealth(), size.y),
          angle: 0)
    ];

    addAll(lifeBarElements);
  }

  double calcLifebarWidthWithCurrnetHealth() {
    return size.x / 100 * currentLife;
  }

  Vector2 _generateLifebarPosition() {
    var yPos = -size.y - _barOffset;
    switch (_placement) {
      case Placement.LEFT:
        return Vector2(0, yPos);
      case Placement.RIGHT:
        return Vector2(_parentSize.width - size.x, yPos);
      case Placement.CENTER:
        return Vector2((_parentSize.width - size.x) / 2, yPos);
      default:
        return Vector2(1, 1);
    }
  }

  void decrementHealth(int point) {
    currentLife -= point;
    if (currentLife < 0) currentLife = 0;
  }

  void incrementHelath(int point) {
    currentLife += point;
    if (currentLife > 100) currentLife = 100;
  }

  @override
  void update(double dt) {
    super.update(dt);
    var healthElement = lifeBarElements[2];

    healthElement.size.x = calcLifebarWidthWithCurrnetHealth();
    healthElement.paint.color = currentColor;
  }
}

class Square extends PositionComponent {
  // default
  Vector2 velocity = Vector2(0, 0).normalized() * 25;
  var squareSize = 152.0;
  var rotationSpeed = 0.45;
  var color = Paint()
    ..color = Colors.orange
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;
  var angleSpeed = 50;
  var shapeNum = 0;
  var lifebar;

  @override
  FutureOr<void> onLoad() {
    size.setValues(squareSize, squareSize);
    anchor = Anchor.center;
    createHealthBar();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
    var angleSpeed = dt * rotationSpeed;
    angle = (angle + angleSpeed) % (2 * pi);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Exercise #1
    // rectangle
    if (shapeNum == 0) {
      canvas.drawRect(size.toRect(), color);
      // Circle
    } else if (shapeNum == 1) {
      canvas.drawOval(size.toRect(), color);
      // Round Rectangle
    } else if (shapeNum == 2) {
      //canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, color);
      canvas.drawRRect(RRect.fromRectXY(size.toRect(), 10, 10), color);
    }
  }

  void createHealthBar() {
    var lifebarSize = Vector2(size.x * 0.8, 10);
    lifebar = LifeBar(
        parentSize: size.toSize(),
        currentLife: 100.0,
        placement: Placement.CENTER,
        healthyColor: Colors.green,
        warningColor: Colors.red,
        size: lifebarSize,
        barOffset: 2,
        warningTheshold: 25);

    add(lifebar);
  }

  void processHit() {
    lifebar.decrementHealth(10);
  }
}

class ComponentExample001 extends FlameGame
    with TapDetector, DoubleTapDetector {
  bool running = true;

  @override
  bool debugMode = false;

  double shapeSize = 45.0;

  TextPaint textPaint = TextPaint(
      style: const TextStyle(
          fontSize: 14, fontFamily: 'AwesomeFont', color: Colors.white));

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    var touchPoint = info.eventPosition.global;

    var handled = children.any((component) {
      if (component is Square && component.containsPoint(touchPoint)) {
        component.processHit();
        component.velocity.negate();
        component.rotationSpeed *= -1;
        return true;
      }
      return false;
    });

    // Exercise #1
    var random = Random();
    var randomVector =
        Vector2(random.nextDouble() * 2 - 1, random.nextDouble() * 2 - 1);
    var randomSpeed = random.nextDouble() * 100;
    var randomPosition =
        Vector2(random.nextDouble() * size.x, random.nextDouble() * size.y);
    if (!handled) {
      add(Square()
        ..squareSize = shapeSize
        ..velocity = randomVector * randomSpeed
        ..position = randomPosition
        ..shapeNum = random.nextInt(3)
        ..color = (BasicPalette.red.paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2));
    }
  }

  @override
  void onDoubleTap() {
    super.onDoubleTap();
    if (running) {
      pauseEngine();
    } else {
      resumeEngine();
    }
    running = !running;
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Exercise #2
    var mySquares = children.query<Square>();
    var myOutOfBoundSquares = mySquares.where((element) =>
        element.position.x < 0 - shapeSize ||
        element.position.x > size.x + shapeSize ||
        element.position.y < 0 - shapeSize ||
        element.position.y > size.y + shapeSize);
    removeAll(myOutOfBoundSquares);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    textPaint.render(canvas, 'Object Count: ${children.query<Square>().length}',
        Vector2(10, 10));
  }
}
