# Habitly 

**Build better habits, one day at a time.**

Habitly is a modern habit tracker application built with Flutter and Dart. It helps users organize their daily routines, track their progress, and stay consistent with their personal goals through a clean and simple interface.

## Features

- **Habit Management:** Add, edit, and delete habits.
- **Weekly Calendar:** Navigate through the days of the week.
- **Daily Progress Tracking:** Track completed habits and monitor daily progress.
- **Streak Tracking:** Keep track of consecutive days of habit completion.
- **Statistics Dashboard:** View habit completion statistics and activity.
- **Dark & Light Mode:** Switch between themes for a comfortable experience.
- **Local State Management:** Manage application data using Provider.

## Built With

- **Flutter** – Cross-platform UI framework.
- **Dart** – Programming language.
- **Provider** – State management.
- **Shared Preferences** – Local storage integration (persistence testing in progress).

## Screenshots

Screenshots will be added soon.

## Project Structure

```text
lib/
├── data/
│   └── mock_habits.dart
├── models/
│   └── habit.dart
├── providers/
│   ├── habit_provider.dart
│   └── settings_provider.dart
├── screens/
│   ├── add_habit_sheet.dart
│   ├── home_screen.dart
│   ├── main_screen.dart
│   ├── my_habits_screen.dart
│   ├── settings_screen.dart
│   └── statistics_screen.dart
├── theme/
│   └── app_theme.dart
├── widgets/
│   ├── habit_card.dart
│   ├── progress_card.dart
│   └── weekly_calendar.dart
├── app.dart
└── main.dart
```

## Getting Started

### Prerequisites

Make sure you have installed:

- Flutter SDK
- Dart SDK
- Visual Studio Code or another code editor

### Installation

1. Clone the repository:

```bash
git clone https://github.com/1xfadwa/habitly.git
```

2. Navigate to the project directory:

```bash
cd habitly
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the application:

```bash
flutter run
```

##  Project Goal

Habitly was developed as a practical project to strengthen my Flutter and Dart skills, practice application architecture and state management, and build a clean user interface.

---

**Built with Flutter **