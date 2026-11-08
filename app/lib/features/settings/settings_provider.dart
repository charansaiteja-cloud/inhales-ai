import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  }) => AppSettings(
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

final settingsProvider = StateNotifierProvider<SettingsNotifier, AsyncValue<AppSettings>>(
  (ref) => SettingsNotifier(),
);

class SettingsNotifier extends StateNotifier<AsyncValue<AppSettings>> {
  SettingsNotifier() : super(const AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    state = AsyncValue.data(const AppSettings());
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = AsyncValue.data(state.value!.copyWith(themeMode: mode));
  }

  Future<void> setOffline(bool value) async {
    state = AsyncValue.data(state.value!.copyWith(offlineMode: value));
  }

  Future<void> setReducedBlur(bool value) async {
    state = AsyncValue.data(state.value!.copyWith(reducedBlur: value));
  }

  Future<void> setReducedAnimation(bool value) async {
    state = AsyncValue.data(state.value!.copyWith(reducedAnimation: value));
  }

  Future<void> setFontSize(double value) async {
    state = AsyncValue.data(state.value!.copyWith(fontSize: value));
  }

  Future<void> setLanguage(String value) async {
    state = AsyncValue.data(state.value!.copyWith(language: value));
  }

  Future<void> setContextLength(int value) async {
    state = AsyncValue.data(state.value!.copyWith(contextLength: value));
  }

  Future<void> setCpuThreads(int value) async {
    state = AsyncValue.data(state.value!.copyWith(cpuThreads: value));
  }

  Future<void> setUseGpu(bool value) async {
    state = AsyncValue.data(state.value!.copyWith(useGpu: value));
  }
}
