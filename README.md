# Service Booking App

## 🚀 Overview

This is a **Service Booking App** built with **Flutter** following **Clean Architecture** principles. Users can sign up, sign in using **Firebase Email Authentication**, and later book services with online payment integration (Razorpay/Stripe - TBD). Admins can manage services through an admin panel to oversee service listings and user bookings.

## 🔥 Features

- **Clean Architecture** for maintainable and scalable codebase
- **User Authentication** (Sign Up, Sign In, Sign Out) using Firebase
- **State Management** using Cubit (Bloc)
- **Dependency Injection** with `get_it`
- **Secure Firebase Keys** (Hidden via `.gitignore`)
- **Responsive UI** for both Mobile & Web
- **Service Selection & Booking (Coming Soon)**
- **Online Payment Integration (Coming Soon)**
- **Admin Panel for Service Management (Coming Soon)**

## 📂 Folder Structure

```
/lib
  ├── core                 # Core utilities & constants
  ├── data                 # Data models, repositories & APIs
  ├── domain               # Business logic (Use cases & Entities)
  ├── presentation         # UI Screens & Cubit State Management
  ├── injection.dart       # Dependency Injection setup
  ├── firebase_options.dart # Firebase Configuration (Not tracked by Git)
```

## 🛠️ Setup Instructions

1. **Clone the repository:**
   ```sh
   git clone https://github.com/yourusername/service-booking-app.git
   cd service-booking-app
   ```
2. **Install dependencies:**
   ```sh
   flutter pub get
   ```
3. **Set up Firebase:**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable **Email/Password Authentication**
   - Download `google-services.json` (Android) & `GoogleService-Info.plist` (iOS)
   - Run Firebase setup:
     ```sh
     flutterfire configure
     ```
4. **Run the app:**
   ```sh
   flutter run
   ```

## 🔐 Environment Variables

To securely store API keys, use **flutter_dotenv**:

1. Install the package:
   ```sh
   flutter pub add flutter_dotenv
   ```
2. Create a `.env` file and add:
   ```sh
   FIREBASE_API_KEY=your_api_key
   ```
3. Load the variables in `main.dart`:
   ```dart
   import 'package:flutter_dotenv/flutter_dotenv.dart';
   await dotenv.load();
   ```

## 🔜 Upcoming Features

✅ **User selects a service** - Users will be able to browse and choose from a list of available services. The selection process will be intuitive, with filters and search functionality for better user experience.

✅ **Online payment integration (Razorpay/Stripe - TBD)** - The app will support secure online payments through Razorpay or Stripe. Users can pay for their selected services directly within the app.

✅ **Admin Panel for managing services** - The admin will have access to a dashboard to manage services, view user bookings, and oversee payment transactions.

## 📜 License

This project is open-source and free to use. Consider using an appropriate license such as MIT or Apache to define usage rights clearly.



