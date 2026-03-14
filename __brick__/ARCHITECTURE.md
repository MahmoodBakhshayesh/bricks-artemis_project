# Application Architecture Guide

Welcome to the project! This document is the definitive guide to our application's architecture. Its purpose is to ensure that every developer, present and future, can build features in a consistent, robust, and maintainable way. Adherence to these patterns is mandatory for all new development.

## Core Philosophy
(Details omitted for brevity)

## The Journey of a User Action (Data Flow)

**`View` -> `Controller` -> `UseCase` -> `Repository` -> `DataSource` -> (API/DB)**

---

## Feature Structure

Our project is organized by features. Each feature is a self-contained module with a flat and predictable structure.

```
└── features/
    └── <feature_name>/
        ├── domain/                     // Business logic & data contracts
        ├── presentation/               // UI layout implementations
        ├── <feature_name>_controller.dart  // The Controller (logic)
        ├── <feature_name>_view.dart        // The View (responsiveness)
        └── <feature_name>_view_state.dart  // The State (data)
```

### The Presentation Layer in Detail

The presentation layer is explicitly designed to be responsive from the ground up.

*   **`<feature_name>_view.dart` (The Dispatcher):** This is the main UI entry point for the feature. It is a simple `StatelessWidget` that contains a `LayoutBuilder`. Its **only** job is to check the screen constraints and return the appropriate screen-specific layout.
*   **`presentation/screens/` (The Layouts):** This folder contains the actual UI layouts for different screen sizes (e.g., `<feature>_view.phone.dart`, `<feature>_view.tablet.dart`). These layout files are `(Hook)ConsumerWidget`s, and they are responsible for rendering the UI and calling the controller.

This pattern cleanly separates the responsive logic from the UI rendering.

---

## 1. The View Layer (`<feature>_view.dart` & `presentation/screens/`)

(Details on View rules, including `HookConsumerWidget`, remain the same)

## 2. The Controller Layer (`<feature>_controller.dart`)

(Details on Controller rules remain the same)

## 3. The State Layer (`<feature>_view_state.dart`)

(Details on State rules remain the same)

## 4. The Domain Layer (`domain/`)

(Details on Domain layer rules remain the same)

---

## Core Patterns in Practice
(Details on core patterns like Provider Overriding remain the same)

## How to Add a New Feature
(Updated to reflect the new flat structure)

1.  **Create Folder:** Create `lib/features/<new_feature>/`.
2.  **Define Domain:** Create the `domain/` folder and its contents (Entities, UseCases, etc.).
3.  **Register Dependencies:** Add the new domain layer classes to `di.dart`.
4.  **Create Presentation Files:**
    *   Create `<new_feature>_view_state.dart` with the necessary `StateProvider`s.
    *   Create `<new_feature>_controller.dart` extending `BaseController`.
    *   Create the layout file(s) in `presentation/screens/`.
    *   Create the main `<new_feature>_view.dart` with the responsive `LayoutBuilder`.
5.  **Add Route:** Add the new route and name to `app_route_names.dart` and `app_routes.dart`.
6.  **Build UI:** Implement the UI layouts, following all architectural rules.
