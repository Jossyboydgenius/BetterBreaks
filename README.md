# BetterBreaks

A Flutter application that demonstrates the BLoC pattern with Provider.

## Project Structure

The project follows a clean architecture approach with the following structure:

```
lib/
  ├── blocs/           # Contains BLoC classes
  │   └── counter/     # Counter BLoC implementation
  │       ├── counter_bloc.dart
  │       ├── counter_event.dart
  │       └── counter_state.dart
  ├── models/          # Data models
  │   └── counter_model.dart
  ├── repositories/    # Data repositories
  ├── screens/         # UI screens
  │   └── counter_screen.dart
  ├── widgets/         # Reusable widgets
  └── main.dart        # Application entry point
```

## BLoC Pattern Implementation

This project demonstrates the BLoC (Business Logic Component) pattern using the `flutter_bloc` and `provider` packages. The BLoC pattern separates the business logic from the UI, making the code more maintainable and testable.

### Key Components:

1. **Events**: Represent user actions or system events that trigger state changes.
2. **States**: Represent the application state at a given point in time.
3. **BLoC**: Handles events and emits new states based on business logic.
4. **UI**: Consumes states and dispatches events.

## Getting Started

To run this project:

1. Ensure you have Flutter installed on your machine.
2. Clone this repository.
3. Run `flutter pub get` to install dependencies.
4. Run `flutter run` to start the application.

## Dependencies

- flutter_bloc: ^8.1.4
- bloc: ^8.1.3
- provider: ^6.1.2
- equatable: ^2.0.5
