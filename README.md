# BetterBreaks

A Flutter application using BLoC pattern with Provider.

## Project Structure

The project follows a clean architecture approach with the following structure:

```
lib/
  ├── app/                # App configuration
  │   ├── routes/         # Navigation routes
  │   ├── app.dart        # Main app widget
  │   ├── flavor_config.dart # Environment configuration
  │   ├── locator.dart    # Dependency injection
  │   └── themes.dart     # App themes
  ├── data/               # Data layer
  │   ├── models/         # Data models
  │   └── services/       # API services
  ├── shared/             # Shared utilities
  │   ├── app_colors.dart # Color constants
  │   ├── app_icons.dart  # Icon utilities
  │   ├── app_images.dart # Image utilities
  │   ├── app_sizer.dart  # Responsive sizing
  │   ├── app_spacing.dart # Spacing utilities
  │   ├── app_textstyle.dart # Text styles
  │   └── version_checker.dart # App version utilities
  ├── ui/                 # UI layer
  │   ├── views/          # App screens
  │   │   ├── authentication/
  │   │   ├── comments/
  │   │   ├── dashboard/
  │   │   ├── members/
  │   │   ├── onboarding/
  │   │   ├── phone_number/
  │   │   ├── profile/
  │   │   ├── projects/
  │   │   ├── tasks/
  │   │   └── wallet/
  │   └── widgets/        # Reusable widgets
  ├── main.dart           # Entry point for development
  └── main_common.dart    # Common initialization code
```

## Architecture

This project uses the BLoC (Business Logic Component) pattern with Provider for state management. The architecture is divided into three main layers:

1. **Data Layer**: Contains models and services for data handling.
2. **Domain Layer**: Contains business logic and repositories.
3. **UI Layer**: Contains screens and widgets.

## Reusable Components

The project includes several reusable components:

- **AppButton**: Customizable button component
- **AppIcons**: SVG icon utilities
- **AppImages**: Image utilities with error handling
- **AppSpacing**: Consistent spacing utilities
- **AppTextStyle**: Typography system
- **AppColors**: Color system

## Environment Configuration

The app supports multiple environments through the FlavorConfig:

- Development
- Staging
- Production

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
- flutter_screenutil: ^5.9.0
- flutter_svg: ^2.0.10+1
- go_router: ^13.2.0
- get_it: ^7.6.7
- package_info_plus: ^5.0.1
