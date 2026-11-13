# Smart AI Fitness Tracker

A Flutter fitness-tracking prototype that helps users explore workout categories and understand basic body metrics and daily nutrition estimates.

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.35%2B-02569B?logo=flutter" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.9%2B-0175C2?logo=dart" alt="Dart">
  <img src="https://img.shields.io/badge/State%20Management-Provider-7B1FA2" alt="Provider">
</p>

## Overview

The prototype guides users through profile setup and body-related selections, then presents estimated body metrics, calorie needs, nutrition guidance, and workout categories. Calculations are intended for educational demonstration and should not be treated as medical advice.

## Features

- Profile setup with age, gender, body type, and body-condition selections
- BMI and BMR calculations with daily calorie estimates
- Basic protein, carbohydrate, and fat recommendations
- Workout categories organized by muscle group
- Arabic and English interface support
- Local storage for selected user information

## Screenshots

Capture the running application and add the images below to show the main user journey.

| Profile setup | Body selection |
|---|---|
| `screenshots/01-profile-setup.png` | `screenshots/02-body-selection.png` |

| Calorie results | Workout categories |
|---|---|
| `screenshots/03-calorie-results.png` | `screenshots/04-workout-categories.png` |

## Built With

- **Flutter & Dart** — cross-platform mobile UI
- **Provider** — state management
- **SharedPreferences** — local persistence
- **Flutter SVG** and **Percent Indicator** — UI components

## Getting Started

### Prerequisites

- Flutter SDK 3.35.7 or later (Dart SDK `^3.9.2`)
- Android Studio or another Flutter-supported IDE
- Android emulator or connected device

### Run locally

```bash
git clone https://github.com/abdallahkali/fitness_tracker.git
cd fitness_tracker
flutter pub get
flutter devices
flutter run
```

Run on a specific device with `flutter run -d <device-id>`.

## Project Structure

The source is organized into Flutter screens, models, providers/services, reusable widgets, and bundled assets.

## Current Scope & Limitations

- This is a learning and graduation-project prototype.
- Profile data is stored locally; production authentication and a backend are not included.
- Fitness, calorie, and nutrition values are estimates for demonstration and educational purposes.
- The repository does not include a deployed or validated AI recommendation service.

## Author

**Abdallah Khalifa** · [GitHub](https://github.com/abdallahkali)

[⬆ Back to top](#smart-ai-fitness-tracker)
