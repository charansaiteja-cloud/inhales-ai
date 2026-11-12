# InhaleSkill UI Widgets

This folder contains the **premium Liquid‑Glass components** used throughout the app. All widgets are built with:

- **Glass‑morphism** (BackdropFilter + custom opacity)
- **Accessibility** (Semantics + FocusableActionDetector)
- **State‑aware theming** (responds to dark / light / high‑contrast modes)
- **Responsive focus ring** (visible when navigating via keyboard)

## Widgets

| Widget | Primary Props | Notes |
|--------|---------------|-------|
| **GlassCard** | `child`, `onTap`, `blur`, `elevated`, `glow` | Now a `StatefulWidget` with a blue focus outline. |
| **GlassButton** | `onTap`, `label`, `outlined`, `glow`, `enabled` | Converted to `StatefulWidget` – faster press animation (150 ms) and focus ring. |
| **GlassBottomNavigationBar**, **GlassDialog**, **GlassSidebar**, … | See each file for full API. |

### How to use

```dart
GlassButton(
  label: 'Start',
  onTap: () => debugPrint('clicked'),
  highContrast: true, // respects the global UI flag automatically
);
```