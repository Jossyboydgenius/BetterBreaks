# BetterBreaks

<p align="center">
  <img src="https://raw.githubusercontent.com/Jossyboydgenius/BetterBreaks/refs/heads/main/assets/images/app_logo.png" alt="BetterBreaks Logo" width="120"/>
</p>

<p align="center">
  <strong>Smart Holiday Planning Made Simple</strong>
</p>

<p align="center">
  A comprehensive Flutter application that helps you maximize your time off with personalized holiday recommendations, analytics, and seamless calendar integration.
</p>

---

## 📱 About

**BetterBreaks** is an intelligent holiday planning application designed to help users optimize their time off work. Whether you're planning a vacation, managing annual leave, or just trying to reduce stress through strategic breaks, BetterBreaks provides data-driven recommendations and insights to help you make the most of your break time.

### Key Features

- **🎯 Smart Holiday Planning**: Get personalized recommendations on when to take breaks based on your schedule and preferences
- **📊 Analytics & Insights**: Track your holiday usage patterns and understand how breaks impact your stress levels
- **📅 Calendar Integration**: Seamlessly sync with your calendar and set blackout dates for important periods
- **🎨 Mood Tracking**: Check in daily with mood tracking to monitor your wellbeing
- **📈 Optimization Timeline**: Visualize your break patterns and identify optimal times for time off
- **⚙️ Customizable Preferences**: Set your leave balance, preferences, and work constraints
- **🌓 Multi-platform Support**: Runs on iOS, Android, Web, macOS, Linux, and Windows

---

## 🏗️ Architecture

BetterBreaks is built using **Clean Architecture** principles with the **BLoC (Business Logic Component)** pattern and **Provider** for state management.

### Architecture Layers

1. **Data Layer**: Handles data models, API services, and repositories
2. **Domain Layer**: Contains business logic and use cases
3. **UI Layer**: Manages screens, widgets, and user interactions

### Project Structure

```
lib/
  ├── app/                    # App-wide configuration
  │   ├── routes/             # Navigation and routing
  │   ├── flavor_config.dart  # Environment configuration (dev/staging/prod)
  │   ├── locator.dart        # Dependency injection setup
  │   └── themes.dart         # App theme definitions
  │
  ├── data/                   # Data layer
  │   ├── models/             # Data models and entities
  │   ├── repositories/       # Repository implementations
  │   └── services/           # API services and external integrations
  │       ├── connection_status.dart
  │       └── in_activity_detector.dart
  │
  ├── shared/                 # Shared utilities and constants
  │   ├── app_colors.dart     # Color palette
  │   ├── app_icons.dart      # Icon utilities and constants
  │   ├── app_images.dart     # Image handling utilities
  │   ├── app_sizer.dart      # Responsive sizing utilities
  │   ├── app_spacing.dart    # Spacing constants
  │   ├── app_textstyle.dart  # Typography system
  │   └── version_checker.dart
  │
  ├── ui/                     # Presentation layer
  │   ├── views/              # App screens
  │   │   ├── analytics/      # Analytics and insights screen
  │   │   ├── auth/           # Authentication flows
  │   │   ├── break_detail/   # Break detail view
  │   │   ├── dashboard/      # Main dashboard
  │   │   ├── event_details/  # Event details screen
  │   │   ├── experience/     # User experience and history
  │   │   ├── onboarding/     # Onboarding flow
  │   │   ├── planner/        # Break planning interface
  │   │   └── setup/          # Initial setup flow
  │   │
  │   └── widgets/            # Reusable UI components
  │       ├── app_buttons.dart
  │       ├── app_bottom_nav.dart
  │       ├── app_top_bar.dart
  │       ├── break_recommendation_widget.dart
  │       ├── mood_check_in.dart
  │       ├── optimization_timeline_chart.dart
  │       └── upcoming_breaks_widget.dart
  │
  ├── main.dart               # App entry point (production)
  └── main_common.dart        # Common initialization logic
```

---

## 🎨 Design System

BetterBreaks features a comprehensive design system for consistent UI/UX:

### Reusable Components

- **AppButton**: Customizable button with multiple variants (filled, outlined, text)
- **AppBottomNav**: Bottom navigation bar for main app sections
- **AppTopBar**: Customizable top app bar with icons and actions
- **AppIcons**: SVG icon management system
- **AppImages**: Image utilities with error handling and caching
- **MoodCheckIn**: Interactive mood tracking widget
- **BreakRecommendationWidget**: Display smart break suggestions
- **OptimizationTimelineChart**: Visualize break patterns over time

### Typography

The app uses multiple custom fonts:
- **Satoshi**: Primary UI font (Light, Regular, Medium, Bold)
- **Raleway**: Secondary font (Light, Medium, SemiBold, Bold)
- **RedRose**: Accent font (Light, Regular, Medium, SemiBold, Bold)
- **Play**: Additional display font (Regular, Bold)
- **Inter Variable**: Variable font for flexible typography

### Responsive Design

Built with `flutter_screenutil` for consistent sizing across different screen dimensions. The app adapts to various device sizes with breakpoints for small, medium, and large screens.

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK: `^3.6.1`
- Dart SDK: `^3.6.1`
- iOS development: Xcode 14+ (for iOS builds)
- Android development: Android Studio with SDK 21+

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/BetterBreaks.git
   cd BetterBreaks
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up environment variables**
   
   Create a `.env` file in the root directory with the following:
   ```env
   BASE_URL_PROD=your_api_base_url
   WEB_URL_PROD=your_web_url
   SENTRY_DSN=your_sentry_dsn
   MIXPANEL_TOKEN_PROD=your_mixpanel_token
   ```

4. **Generate launcher icons** (optional)
   ```bash
   flutter pub run flutter_launcher_icons
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

### Running on Different Platforms

```bash
# iOS
flutter run -d ios

# Android
flutter run -d android

# Web
flutter run -d chrome

# macOS
flutter run -d macos

# Windows
flutter run -d windows

# Linux
flutter run -d linux
```

---

## 📦 Dependencies

### State Management & Architecture
- **flutter_bloc** `^8.1.4` - BLoC pattern implementation
- **bloc** `^8.1.3` - Core BLoC library
- **provider** `^6.1.2` - State management
- **equatable** `^2.0.5` - Value equality
- **get_it** `^7.6.7` - Dependency injection

### UI & Styling
- **flutter_screenutil** `^5.9.0` - Responsive sizing
- **flutter_svg** `^2.0.10+1` - SVG rendering
- **bot_toast** `^4.1.3` - Toast notifications
- **dots_indicator** `^3.0.0` - Page indicators
- **fl_chart** `^0.70.2` - Chart visualizations
- **easy_pie_chart** `^1.0.2` - Pie chart widgets

### Navigation & Routing
- **go_router** `^13.2.0` - Declarative routing

### Network & Data
- **dio** `^5.4.0` - HTTP client
- **connectivity_plus** `^5.0.2` - Network connectivity monitoring

### Utilities
- **package_info_plus** `^5.0.1` - App version and info
- **flutter_dotenv** `^5.1.0` - Environment configuration
- **intl** `^0.18.0` - Internationalization and date formatting
- **cupertino_icons** `^1.0.8` - iOS-style icons

### Development
- **flutter_test** - Testing framework
- **flutter_lints** `^5.0.0` - Linting rules
- **flutter_launcher_icons** `^0.13.1` - Generate launcher icons

---

## 🌍 Environment Configuration

BetterBreaks supports multiple build flavors for different environments:

- **Development**: For local development with debug features
- **Staging**: Pre-production testing environment
- **Production**: Live production environment

Environment-specific configuration is managed through the `FlavorConfig` class and `.env` files.

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

---

## 🏗️ Building for Release

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

### Desktop
```bash
flutter build macos --release
flutter build windows --release
flutter build linux --release
```

---

## 📱 Features Overview

### 1. Onboarding
- Three-screen onboarding flow introducing key features
- Beautiful illustrations and smooth page transitions
- Sign up and sign in options

### 2. Dashboard
- Quick overview of upcoming breaks
- Smart break recommendations
- Mood check-in widget
- Analytics snapshot
- Leave balance display

### 3. Break Planner
- Calendar view for planning breaks
- Blackout date management
- Break duration calculator
- Leave balance tracking

### 4. Experience
- Historical break data
- Past break reviews
- Memory timeline

### 5. Analytics
- Break usage patterns
- Stress level tracking over time
- Optimization recommendations
- Interactive charts and visualizations

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is private and not published to pub.dev.

---

## 👥 Authors

Developed with ❤️ by the BetterBreaks team

---

## 📞 Support

For support, please open an issue in the GitHub repository or contact the development team.

---

## 🎯 Roadmap

- [ ] Integration with major calendar providers (Google Calendar, Outlook)
- [ ] Machine learning-based break recommendations
- [ ] Team collaboration features
- [ ] Export reports and analytics
- [ ] Dark mode support
- [ ] Multi-language support
- [ ] Notification system for break reminders
- [ ] Sync across devices

---

**Made with Flutter 💙**
