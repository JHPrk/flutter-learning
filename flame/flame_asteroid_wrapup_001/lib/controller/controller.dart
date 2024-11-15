import 'package:flame/components.dart';
import 'package:flame_asteroid_wrapup_001/command/broker.dart';
import 'package:flame_asteroid_wrapup_001/command/command.dart';
import 'package:flame_asteroid_wrapup_001/main.dart';
import 'package:flame_asteroid_wrapup_001/spaceship.dart';

class Controller extends Component with HasGameRef<AsteroidGame> {
  final Broker _broker = Broker();

  Spaceship getSpaceship() => game.player;

  void addCommand(Command command) {
    _broker.addCommand(command);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _broker.process();
  }
}
