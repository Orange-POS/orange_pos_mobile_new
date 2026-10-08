# OrangePOS Mobile Inventory Application

A Flutter-based mobile inventory application designed to integrate with the Odoo backend for inventory and product management.

## Tech Stack

- Flutter and Dart
- Very Good CLI
- Riverpod — State Management and Dependency Injection
- GoRouter — Navigation
- Dio — HTTP Client
- Odoo — Backend Integration (Planned)
- Mobile Scanner — QR and Barcode Scanning

## Prerequisites

- Flutter SDK compatible with the project
- Dart SDK compatible with the project
- Android Studio or VS Code
- Android SDK


## Getting Started

Clone the repository:

```bash
git clone https://github.com/Orange-POS/orange_pos_mobile_new.git
cd orange_pos_mobile_new
```

Install dependencies:

```bash
flutter pub get
```

## Running the Application

### Development

```bash
flutter run --flavor development -t lib/main_development.dart
```

### Staging

```bash
flutter run --flavor staging -t lib/main_staging.dart
```

### Production

```bash
flutter run --flavor production -t lib/main_production.dart
```

## Code Quality

Format the code:

```bash
dart format lib test
```

Analyze the code:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

## Project Architecture

The project is being developed using a feature-first architecture with presentation, domain, and data layers.

Shared application functionality will be organized in core and shared modules.

## Development Status

The initial Flutter project setup, flavor configuration, Riverpod foundation, and GoRouter navigation foundation are in place.

Odoo backend integration and inventory management features are under development.

