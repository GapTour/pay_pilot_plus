# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**pay_pilot_plus** is a Flutter application for managing member payments and financial operations. It supports multiple platforms (iOS, Android, macOS, Linux, Web) with Persian localization and complex financial data management.

**Key Technologies:**
- **State Management:** BLoC + Flutter BLoC
- **Database:** Drift (SQLite local database with DAO pattern)
- **Dependency Injection:** GetIt
- **Navigation:** GoRouter
- **Localization:** intl + intl_utils (Persian as primary locale)
- **Architecture:** Clean Architecture with feature-based organization

## Code Architecture

### Directory Structure

```
lib/
├── core/                    # Shared code across features
│   ├── database/           # Drift database, DAOs, tables, schemas
│   ├── widgets/            # Reusable UI components (app_tile, app_dialog, etc.)
│   ├── utils/              # Constants, formatters, helpers, theme, routing
│   ├── l10n/               # Localization (ARB files → generated l10n code)
│   └── data/               # Enums and shared data models
├── features/               # Feature modules (teams, members, events, funds, etc.)
│   ├── {feature}/
│   │   ├── data/          # Local providers (data layer)
│   │   ├── presentation/  # UI pages, widgets, BLoCs/Cubits
│   │   └── repository/    # Business logic repositories
│   └── ...
├── locator.dart           # GetIt dependency injection setup
└── main.dart              # App entry point and root widget

scripts/                    # Utility scripts
├── update_versions.sh     # Update version across all platforms
└── generate_drift_web_workers.sh

android/, ios/, macos/, linux/, web/  # Platform-specific code
```

### Architecture Layers

**Presentation Layer** → **Repository Layer** → **Data Layer** → **Database/Providers**

- **Presentation:** Pages, widgets, BLoCs/Cubits (state management)
- **Repository:** Interfaces and implementations, business logic aggregation
- **Data Layer:** Local providers (data sources), interfaces
- **Database:** Drift DAOs and tables, accessed via providers

### Feature Modules

Each feature (teams, members, events, funds, etc.) follows Clean Architecture:
- `presentation/` - UI and state management (BLoC/Cubit)
- `data/providers/` - Data sources (implement interfaces defined in repositories)
- `repository/` - Business logic, public interfaces for features

### Dependency Injection

`locator.dart` registers all dependencies in order:
1. **Services:** AppDatabase, SharedPreferences, AccountsChartSeederService, etc.
2. **DAOs:** Database access objects (lazy singletons)
3. **Providers:** Data layer implementations
4. **Repositories:** Business logic layer

Access dependencies: `locator<SomeService>()` or `locator<SomeRepository>()`

### Database Layer

- **Engine:** Drift with SQLite
- **Location:** `/lib/core/database/`
- **DAOs:** One per entity (users, teams, journals, funds, etc.)
- **Tables:** Defined in `/lib/core/database/tables/`
- **Schema Versions:** Track migrations in `schema_versions.dart`

After database changes, run: `flutter pub run build_runner build`

## Common Development Commands

### Setup & Dependencies
```bash
flutter pub get              # Install dependencies
flutter pub upgrade          # Upgrade dependencies
flutter pub outdated         # Check outdated packages
```

### Code Generation
```bash
flutter pub run build_runner build      # Generate Drift, Flutter Gen, intl code
flutter pub run build_runner clean      # Clean generated files
flutter pub run build_runner watch      # Watch and auto-generate on file changes
```

### Code Quality
```bash
flutter analyze             # Lint code (uses flutter_lints)
flutter format --line-length=100  # Format code
```

### Testing
```bash
flutter test                # Run all tests
flutter test test/widget_test.dart  # Run specific test file
flutter test -k "pattern"   # Run tests matching pattern
```

### Building & Running
```bash
flutter run                 # Run on connected device/emulator
flutter run -d chrome       # Run on web
flutter run -d windows      # Run on Windows desktop
flutter run -d macos        # Run on macOS desktop

# Release builds
flutter build ios --release
flutter build android --release
flutter build macos --release
flutter build web --release
flutter build linux --release
```

### Versioning
```bash
./scripts/update_versions.sh  # Update version across all platforms (requires version_config.json)
```

## Key Files & Patterns

### Localization (i18n)
- **Source Files:** `/lib/core/l10n/*.arb` (ARB format, Persian primary)
- **Generated:** `/lib/core/l10n/generated/` (auto-generated, don't edit)
- **Usage:** `S.of(context).stringKey`
- **Generate:** Included in `build_runner build`

### Routing
- **Router Config:** `lib/core/utils/resources/app_routes.dart`
- **Pattern:** GoRouter with named routes
- **Navigation:** Use `context.go()` or `context.push()` from GoRouter

### State Management
- **Pattern:** BLoC (Bloc) or Cubit (simpler, state only)
- **Event Sourcing:** Blocs emit events, handle them, emit new states
- **Cubits:** Direct state mutation (no events)
- **Listeners:** Use `BlocListener` for side effects, `BlocBuilder` for UI

### Database Queries
- **Query Pattern:** Use DAOs via repository
- **Example:** `await locator<IJournalsRepository>().getJournals()`
- **After Schema Changes:** Run `flutter pub run build_runner build` to regenerate

### UI Components
- Reusable widgets in `/lib/core/widgets/`
- Naming: `app_*` prefix (e.g., `app_tile.dart`, `app_dialog_box.dart`)
- Use these instead of duplicating Material widgets

### Theming
- **Theme File:** `lib/core/utils/theme/app_theme.dart`
- **Primary:** Dark theme enforced
- **Fonts:** IranSansX (Persian, bold/medium/regular) in `pubspec.yaml`

## Platform-Specific Notes

- **iOS/Android:** Standard Flutter mobile setup
- **macOS/Linux:** Desktop builds, minimum window size 600x850
- **Web:** Uses Flutter Web, generated workers for Drift
- **Window Manager:** Configured for desktop platforms (macOS, Windows)

## CI/CD

**GitHub Actions Workflow:** `.github/workflows/app_release.yaml`
- **Trigger:** Push tags matching `v*.*.*`
- **Jobs:**
  1. Build macOS release → Package as ZIP
  2. Build Android APK → Package as APK
- **Artifacts:** Retained for 1 day
- **Next Step:** Manually create GitHub release and attach artifacts

## Development Workflow

1. **Checkout/Pull Latest:** `git pull`
2. **Install Dependencies:** `flutter pub get`
3. **Generate Code:** `flutter pub run build_runner build` (for Drift/intl changes)
4. **Run App:** `flutter run` (mobile) or `flutter run -d chrome` (web)
5. **Make Changes:** Create feature in `/lib/features/` or modify existing
6. **Code Quality:** `flutter analyze` and `flutter format`
7. **Test:** `flutter test` (if tests exist)
8. **Version Update:** `./scripts/update_versions.sh` (requires `version_config.json`)
9. **Commit & Push:** Standard git workflow

## Important Notes

- **Database Migrations:** Update schema in `/lib/core/database/tables/`, increment schema version, regenerate
- **Feature Isolation:** Each feature is self-contained; minimize cross-feature dependencies
- **Persian Localization:** Primary locale is Persian; always check RTL behavior for UI
- **Drift Code Gen:** Generated files (`*.g.dart`) should not be manually edited
- **GetIt Scope:** All dependencies in `locator.dart`; add new services/repos there first
