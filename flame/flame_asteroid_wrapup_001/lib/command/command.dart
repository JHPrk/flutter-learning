import 'package:flame/components.dart';
import 'package:flame_asteroid_wrapup_001/objects/bullet/bullet_factory.dart';
import 'package:flame_asteroid_wrapup_001/controller/controller.dart';
import 'package:flame_asteroid_wrapup_001/spaceship.dart';
import 'package:flame_audio/flame_audio.dart';

abstract class Command {
  Command();
  late Controller _controller;

  void addToController(Controller controller) {
    _controller = controller;
    _controller.addCommand(this);
  }

  Controller _getController() => _controller;

  void execute();

  String getTitle();
}

class UserTapCommand extends Command {
  Spaceship player;

  UserTapCommand(this.player);

  @override
  void execute() {
    BulletFiredCommand().addToController(_getController());
    BulletFiredSoundCommand().addToController(_getController());
  }

  @override
  String getTitle() {
    return "UserTapCommand";
  }
}

class BulletFiredCommand extends Command {
  BulletFiredCommand();
  @override
  void execute() {
    Vector2 velocity = Vector2(0, -1);

    velocity.rotate(_getController().getSpaceship().angle);

    BulletBuildContext context = BulletBuildContext()
      ..position =
          _getController().getSpaceship().muzzleComponent.absolutePosition
      ..size = Vector2(4, 4)
      ..velocity = velocity;

    var bullet = BulletFactory.creates(
        _getController().getSpaceship().getBulletEnum, context);

    _getController().add(bullet);
  }

  @override
  String getTitle() {
    return "BulletFiredCommand";
  }
}

class BulletFiredSoundCommand extends Command {
  BulletFiredSoundCommand();
  @override
  void execute() {
    FlameAudio.play("missile_shot.wav");
    FlameAudio.play("missile_flyby.wav");
  }

  @override
  String getTitle() {
    return "BulletFiredSoundCommand";
  }
}

class IncreaseBulletCountCommand extends Command {
  @override
  void execute() {
    // TODO: implement execute
  }

  @override
  String getTitle() {
    return "IncreaseBulletCountCommand";
  }
}
