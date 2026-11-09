# InhaleSkill AI — Changelog

## Phase 2: Liquid Glass Premium Redesign — 2026-11-09

### Design System
- **Color Palette**: Deep midnight navy (#0A0E1A) primary dark theme with electric blue (#5B8CFF), soft cyan (#85FFFF), violet (#9B87FF) accents; full light/dark theme support
- **Design Tokens**: Centralized in `inhale_tokens.dart` (spacing, radius, blur, opacity, shadows) and `inhale_colors.dart` (semantic colors, gradients)
- **Typography**: Premium scale with Inter/SF Pro Display, responsive to accessibility text scaling

### Core Widgets (Premium Liquid Glass)
- `GlassCard` — frosted blur surfaces, elevated/glow variants, `RepaintBoundary` optimization, `accessibleNavigation`/`reduceAnimation` aware
- `GlassButton` — gradient primary, outlined, icon-only; `FocusableActionDetector` + `Semantics` for a11y
- `GlassTextField` — focus animations, clear/error states, cursor theming
- `GlassChatBubble` — streaming indicator dots, user/AI avatars, AA-contrast colors, `Semantics` roles
- `AIOrb` — breathing/listening/processing/speaking states with `AnimationController`, `RepaintBoundary`
- `GlassIconButton`, `GlassSearchBar`, `GlassAppBar`, `GlassBottomNavigationBar`, `GlassBackground` — all with blur, semantics, reduced-motion support
- `GlassDialog`, `GlassBottomSheet`, `GlassLoadingIndicator`, `GlassStatusBadge`, `GlassSidebar` — complete glass component set

### Feature Screens Redesigned (15 total)
| Screen | Highlights |
|--------|------------|
| **Home** | Dashboard tiles, AIOrb hero, glass cards, responsive grid |
| **Chat** | Streaming bubbles, AIOrb integration, model selector, file attachments |
| **Model Manager** | Drift-persisted install/delete/setActive, download progress, cancel support, loading/error banners |
| **Documents** | Search filtering, GUID order preservation, glass list items |
| **School / College / Coding / Notes / Vision / Voice / Translation / Math / Quizzes / Writing / Presentations** | All feature modes with adaptive styling, error states, animation polish |
| **Settings / General** | Scrollable layouts, theme/accessibility toggles, feedback actions, nav polish |

### Provider & Data Layer Fixes
- `ModelManagerNotifier` wired to `ModelRepositoryImpl` (Drift) for CRUD persistence
- `VoiceScreen` cleaned to match `voiceProvider` API (no `mode`/`processing` fields)
- `VisionScreen` fixed to match `visionProvider` API (`image` not `imageFile`, mock file util)
- `DocumentsScreen` search filtering implemented with unique GUID keys
- Error handling: Voice permission dialog fallback, Chat generation `errorSnack`, ModelManager DB loading banner

### Accessibility & Performance
- **Semantics**: All interactive widgets wrap `Semantics` (button, label, onTap)
- **Focus**: `FocusableActionDetector` / `TapRegion` for keyboard/touch parity
- **Contrast**: AA-level text on glass surfaces (replaced `textMuted` on names)
- **Reduced Motion**: `MediaQuery.reduceMotion` honored; animation controllers respect flag
- **High Contrast**: `accessibleNavigation` disables `BackdropFilter` blur when enabled
- **RepaintBoundary**: Wrapped AIOrb, list items, backdrop, animated cards to reduce overdraw
- **Font Scaling**: All text respects `MediaQuery.textScaler`

### CI Verification
```
flutter analyze  → 0 errors
flutter test     → 2/2 passing
dart format      → clean
```

---

## Phase 1: Clean Architecture & CI Stabilization (earlier)
- Drift migrations, GoRouter signatures, AsyncValue handlers fixed
- Duplicate classes removed, math modulo bug fixed
- `database.g.dart` committed
- All providers compile; routing stable