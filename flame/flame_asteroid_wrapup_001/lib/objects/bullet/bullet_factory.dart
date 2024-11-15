import 'package:flame/game.dart';
import 'package:flame_asteroid_wrapup_001/objects/bullet/bullet.dart';

class BulletFactory {
  BulletFactory._();

  static Bullet creates(BulletEnum choice, BulletBuildContext context) {
    Bullet result;

    switch (choice) {
      case BulletEnum.slowBullet:
        {
          if (context.speed != BulletBuildContext.defaultSpeed) {
            result = SlowBullet.fullInit(
                position: context.position,
                velocity: context.velocity,
                size: context.size,
                speed: context.speed,
                damage: context.damage,
                health: context.health);
          } else {
            result = SlowBullet(
                position: context.position,
                velocity: context.velocity,
                size: context.size);
          }
        }
        break;
      case BulletEnum.fastBullet:
        {
          if (context.speed != BulletBuildContext.defaultSpeed) {
            result = FastBullet.fullInit(
                position: context.position,
                velocity: context.velocity,
                size: context.size,
                speed: context.speed,
                damage: context.damage,
                health: context.health);
          } else {
            result = FastBullet(
                position: context.position,
                velocity: context.velocity,
                size: context.size);
          }
        }
        break;
    }

    result.onCreate();

    return result;
  }
}

class BulletBuildContext {
  static const double defaultSpeed = 0.0;
  static const int defaultHealth = 1;
  static const int defaultDamage = 1;
  static final Vector2 defaultVelocity = Vector2.zero();
  static final Vector2 defaultPosition = Vector2(-1, -1);
  static final Vector2 defaultSize = Vector2.zero();

  double speed = defaultSpeed;
  int health = defaultHealth;
  int damage = defaultDamage;
  Vector2 velocity = defaultVelocity;
  Vector2 position = defaultPosition;
  Vector2 size = defaultSize;

  BulletBuildContext();
}
