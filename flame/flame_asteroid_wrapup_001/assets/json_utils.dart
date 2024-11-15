import 'dart:convert';

import 'package:flame_asteroid_wrapup_001/objects/asteroid/asteroid_factory.dart';
import 'package:flutter/services.dart';

class JSONUtils {
  JSONUtils._();

  static dynamic readJSONInitData() async {
    final String response =
        await rootBundle.loadString('assets/game_config.json');
    final data = await json.decode(response);
    return data;
  }

  static List<GameLevel> extractGameLevels(dynamic data) {
    List<GameLevel> result = List.empty(growable: true);

    List _jsonDataLevels = [];
    _jsonDataLevels = data["game_data"]["levels"];

    for (var level in _jsonDataLevels) {
      GameLevel gameLevel = GameLevel();
      List<AsteroidBuildContext> asteroidContextList =
          _buildAsteroidData(level);
      List<GameLBonusBuildContext> gameBonusContextList =
          _buildGameBonusData(level);

      gameLevel
        ..asteroidConfig = asteroidContextList
        ..gameBonusConfig = gameBonusContextList;
      result.add(gameLevel);
    }
  }

  static List<AsteroidBuildContext> _buildAsteroidData(level) {}

  static List<GameLBonusBuildContext> _buildGameBonusData(level) {}
}

class GameLBonusBuildContext {}

class GameLevel {
  List<AsteroidBuildContext> asteroidConfig =
      List<AsteroidBuildContext>.empty(growable: true);
  List<GameLBonusBuildContext> gameBonusConfig =
      List<GameLBonusBuildContext>.empty(growable: true);
}
