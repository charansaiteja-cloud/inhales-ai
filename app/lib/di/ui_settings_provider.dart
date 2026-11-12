import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds the current UI‑theme selection.
class UiSettings {
  final ThemeMode mode;
  final bool highContrast; // true => use the high‑contrast palettes
  const UiSettings({required this.mode, this.highContrast = false});
}

final uiSettingsProvider = StateProvider<UiSettings>(
    (ref) => const UiSettings(mode: ThemeMode.system));
