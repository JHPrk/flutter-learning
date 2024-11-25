import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:logging/logging.dart';

part 'temp_settings_state.dart';

class TempSettingsProvider extends StateNotifier<TempSettingsState> {
  static final Logger _log = Logger('TempSettingsProvider');

  TempSettingsProvider() : super(TempSettingsState.initial());

  void toggleTempUnit() {
    state = state.copyWith(
        tempUnit: state.tempUnit == TempUnit.celcius
            ? TempUnit.fahrenheit
            : TempUnit.celcius);
    _log.info('temp unit: $state');
  }
}
