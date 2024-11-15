import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum AsteroidEnum { smallAsteroid, mediumAsteroid, largeAsteroid }

abstract class Asteroid extends PositionComponent with CollisionCallbacks {
  final AsteroidEnum asteroidType = AsteroidEnum.largeAsteroid;
  static const double defaultSpeed = 10;
  static const int defaultHealth = 1;
  static const int defaultDamage = 1;

  double _speed;
  Vector2 _velocity;
  int _health;
  int get health => _health;
  int _damage;
  int get damage => _damage;

  Asteroid({super.position, super.size, required Vector2 velocity})
      : _velocity = velocity,
        _speed = defaultSpeed,
        _health = defaultHealth,
        _damage = defaultDamage;

  Asteroid.fullinit(
      {super.position,
      super.size,
      required Vector2 velocity,
      double? speed,
      int? health,
      int? damage})
      : _velocity = velocity,
        _speed = speed ?? defaultSpeed,
        _health = health ?? defaultHealth,
        _damage = damage ?? defaultDamage;

  void onCreate();
  void onDestroy();
  void onHit(PositionComponent other);
  bool canBeSplit() {
    return asteroidType != AsteroidEnum.smallAsteroid;
  }

  List<AsteroidEnum> getSplitAsteroids();
}
