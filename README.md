# Smart AI Fitness Tracker

A Flutter fitness-tracking prototype that helps users explore workout categories and understand basic body metrics and daily nutrition estimates.

## Features

- Profile setup with age, gender, body type, and body-condition selections
- BMI and BMR calculations with daily calorie estimates
- Basic protein, carbohydrate, and fat recommendations
- Workout categories organized by muscle group
- Arabic and English interface support
- Local storage for selected user information

## Tech Stack

- Flutter and Dart
- Provider for state management
- SharedPreferences for local persistence
- Flutter SVG and Percent Indicator packages

## Screenshots

Real in-app screenshots have not been added to this repository yet. They should be captured from a running build and placed in a `screenshots/` folder. Suggested captures:

- `screenshots/01-profile-setup.png`
- `screenshots/02-body-selection.png`
- `screenshots/03-calorie-results.png`
- `screenshots/04-workout-categories.png`

> The images currently in `assets/` are app assets, not screenshots of the running interface.

## Getting Started

### Requirements

- Flutter SDK **3.35.7 or later** (the project uses Dart SDK `^3.9.2`)
- Android Studio or another Flutter-supported IDE
- An Android emulator or a connected device

### Run locally

1. Clone the repository:
   ```bash
   git clone https://github.com/abdallahkali/fitness_tracker.git
   ```
2. Open the project directory:
   ```bash
   cd fitness_tracker
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Check available devices:
   ```bash
   flutter devices
   ```
5. Run the app:
   ```bash
   flutter run
   ```

To run on a specific device, use `flutter run -d <device-id>`.

## Project Structure

The source is organized around Flutter screens, models, providers/services, reusable widgets, and bundled assets.

## Data and Limitations

- This is a learning/graduation-project prototype.
- Current profile data is stored locally; a production authentication service and backend are not included.
- Fitness, calorie, and nutrition values are estimates for demonstration and educational purposes, not medical advice.
- The project does not claim a deployed or validated AI recommendation service in its current repository version.

## Repository

https://github.com/abdallahkali/fitness_tracker
