# ShopEase

ShopEase is a Flutter-based product shopping application developed as part of a Flutter developer machine test.

The application includes product browsing, search, category filtering, product details, cart management, login validation, SQLite-based login session storage, and REST API integration.

## Flutter Version

Flutter 3.47.1

## Dart Version

Dart 3.13.1


## Packages Used

- provider
- dio
- sqflite
- path

## Features

- Login screen with email and password validation
- Dummy login functionality
- SQLite-based login session
- Product listing from DummyJSON API
- Product search
- Product category filtering
- Pull-to-refresh
- Responsive product grid
- Product details screen
- Product rating and pricing
- Recommended products
- Add to cart
- Increase and decrease product quantity
- Remove products from cart
- Cart total calculation
- Checkout navigation
- Reusable product card widget

## Technologies Used

- Flutter
- Dart
- Provider
- Dio
- SQLite
- REST API
- Material Design

## API

Product data is fetched from:

https://dummyjson.com/products

## Project Structure

```text
lib/
├── main.dart
├── models/
│   └── product.dart
├── services/
│   ├── api_service.dart
│   └── database_service.dart
├── providers/
│   ├── auth_provider.dart
│   ├── product_provider.dart
│   └── cart_provider.dart
├── screens/
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── product_detailscreen.dart
│   └── cart_screen.dart
└── widgets/
    └── product_card.dart