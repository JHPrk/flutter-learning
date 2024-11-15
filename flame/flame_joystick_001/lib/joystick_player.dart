import 'package:flame/components.dart';
import 'package:flame_joystick_001/main.dart';
import 'package:flame_joystick_001/utils.dart';

class JoystickPlayer extends SpriteComponent with HasGameRef<JoystickExample> {
  var maxSpeed = 200.0;
  late Vector2 currentVelocity;
  JoystickComponent joystick;

  JoystickPlayer(this.joystick, {super.size});

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('asteroids_ship.png');
    position = game.size / 2;
    anchor = Anchor.center; // 빼먹음
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    currentVelocity = joystick.delta.isZero()
        ? Vector2.zero()
        : joystick.relativeDelta * maxSpeed;
    if (!joystick.delta.isZero()) {
      position += joystick.relativeDelta * maxSpeed * dt;
      angle = joystick.delta.screenAngle();
    }
    Utils.adjustOjbectOutsideScreen(position, gameRef.size);
  }
}
