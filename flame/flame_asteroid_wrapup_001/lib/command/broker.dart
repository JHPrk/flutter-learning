import 'package:flame_asteroid_wrapup_001/command/command.dart';

class Broker {
  final List<Command> _commandList = List<Command>.empty(growable: true);
  final List<Command> _commandPendingList = List<Command>.empty(growable: true);
  Broker();

  void process() {
    for (Command command in _commandList) {
      print("{Executing command : $command}");
      command.execute();
    }

    _commandList.clear();
    _commandList.addAll(_commandPendingList);
    _commandPendingList.clear();
  }

  void addCommand(Command command) {
    print("{Adding command : $command}");
    _commandPendingList.add(command);
  }
}
