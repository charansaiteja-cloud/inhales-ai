import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;

import '../../../di/di.dart';
import '../../database/database.dart';

/// User settings state.
class AppSettings {
  final ThemeMode themeMode;
  final bool offlineMode;
  final bool reducedBlur;
  final bool reducedAnimation;
  final double fontSize;
  final String language;
  final int contextLength;
  final int cpuThreads;
  final bool useGpu;
  final double speechSpeed;
  final bool speechEnabled;

  const AppSettings({
    this.themeMode = ThemeMode.light,
    this.offlineMode = true,
    this.reducedBlur = false,
    this.reducedAnimation = false,
    this.fontSize = 1.0,
    this.language = 'en',
    this.contextLength = 2048,
    this.cpuThreads = 4,
    this.useGpu = false,
    this.speechSpeed = 1.0,
    this.speechEnabled = false,
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    bool? offlineMode,
    bool? reducedBlur,
    bool? reducedAnimation,
    double? fontSize,
    String? language,
    int? contextLength,
    int? cpuThreads,
    bool? useGpu,
    double? speechSpeed,
    bool? speechEnabled,
  }) =>
      AppSettings(
        themeMode: themeMode ?? this.themeMode,
        offlineMode: offlineMode ?? this.offlineMode,
        reducedBlur: reducedBlur ?? this.reducedBlur,
        reducedAnimation: reducedAnimation ?? this.reducedAnimation,
        fontSize: fontSize ?? this.fontSize,
        language: language ?? this.language,
        contextLength: contextLength ?? this.contextLength,
        cpuThreads: cpuThreads ?? this.cpuThreads,
        useGpu: useGpu ?? this.useGpu,
        speechSpeed: speechSpeed ?? this.speechSpeed,
        speechEnabled: speechEnabled ?? this.speechEnabled,
      );

  Map<String, dynamic> toJson() => {
        'themeMode': themeMode.index,
        'offlineMode': offlineMode,
        'reducedBlur': reducedBlur,
        'reducedAnimation': reducedAnimation,
        'fontSize': fontSize,
        'language': language,
        'contextLength': contextLength,
        'cpuThreads': cpuThreads,
        'useGpu': useGpu,
        'speechSpeed': speechSpeed,
        'speechEnabled': speechEnabled,
      };

  static AppSettings fromJson(Map<String, dynamic> json) => AppSettings(
        themeMode: ThemeMode.values[json['themeMode'] ?? 0],
        offlineMode: json['offlineMode'] ?? true,
        reducedBlur: json['reducedBlur'] ?? false,
        reducedAnimation: json['reducedAnimation'] ?? false,
        fontSize: (json['fontSize'] ?? 1.0).toDouble(),
        language: json['language'] ?? 'en',
        contextLength: json['contextLength'] ?? 2048,
        cpuThreads: json['cpuThreads'] ?? 4,
        useGpu: json['useGpu'] ?? false,
        speechSpeed: (json['speechSpeed'] ?? 1.0).toDouble(),
        speechEnabled: json['speechEnabled'] ?? false,
      );
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, AsyncValue<AppSettings>>(
  (ref) => SettingsNotifier(ref.watch(databaseProvider)),
);

class SettingsNotifier extends StateNotifier<AsyncValue<AppSettings>> {
  final AppDatabase _database;

  SettingsNotifier(this._database)
      : super(const AsyncValue.data(AppSettings())) {
    _load();
  }

  Future<void> _load() async {
    final settings = await _loadSettings();
    state = AsyncValue.data(settings);
  }

  Future<AppSettings> _loadSettings() async {
    final prefs = await (_database.select(_database.preferences)
          ..where((p) => p.key.equals('app_settings')))
        .getSingleOrNull();

    if (prefs == null) {
      return const AppSettings();
    }

    try {
      final json = Map<String, dynamic>.from(jsonDecode(prefs.value) as Map);
      return AppSettings.fromJson(json);
    } catch (_) {
      return const AppSettings();
    }
  }

  Future<void> _saveSettings(AppSettings settings) async {
    final json = jsonEncode(settings.toJson());
    await (_database.update(_database.preferences)
          ..where(
            (p) => p.key.equals('app_settings'),
          ))
        .write(PreferencesCompanion(value: drift.Value(json)));
  }

  Future<void> setTheme(ThemeMode mode) async {
    final settings = state.value!.copyWith(themeMode: mode);
    state = AsyncValue.data(settings);
    await _saveSettings(settings);
  }

  Future<void> setOffline(bool value) async {
    final settings = state.value!.copyWith(offlineMode: value);
    state = AsyncValue.data(settings);
    await _saveSettings(settings);
  }

  Future<void> setReducedBlur(bool value) async {
    final settings = state.value!.copyWith(reducedBlur: value);
    state = AsyncValue.data(settings);
    await _saveSettings(settings);
  }

  Future<void> setReducedAnimation(bool value) async {
    final settings = state.value!.copyWith(reducedAnimation: value);
    state = AsyncValue.data(settings);
    await _saveSettings(settings);
  }

  Future<void> setFontSize(double value) async {
    final settings = state.value!.copyWith(fontSize: value);
    state = AsyncValue.data(settings);
    await _saveSettings(settings);
  }

  Future<void> setLanguage(String value) async {
    final settings = state.value!.copyWith(language: value);
    state = AsyncValue.data(settings);
    await _saveSettings(settings);
  }

  Future<void> setContextLength(int value) async {
    final settings = state.value!.copyWith(contextLength: value);
    state = AsyncValue.data(settings);
    await _saveSettings(settings);
  }

  Future<void> setCpuThreads(int value) async {
    final settings = state.value!.copyWith(cpuThreads: value);
    state = AsyncValue.data(settings);
    await _saveSettings(settings);
  }

  Future<void> setUseGpu(bool value) async {
    final settings = state.value!.copyWith(useGpu: value);
    state = AsyncValue.data(settings);
    await _saveSettings(settings);
  }

  Future<void> setSpeechSpeed(double value) async {
    final settings = state.value!.copyWith(speechSpeed: value);
    state = AsyncValue.data(settings);
    await _saveSettings(settings);
  }

  Future<void> setSpeechEnabled(bool value) async {
    final settings = state.value!.copyWith(speechEnabled: value);
    state = AsyncValue.data(settings);
    await _saveSettings(settings);
  }
}
