
# 🔔 Flutter Animated Toast Module

A plug-and-play Flutter module for animated toasts and snackbars. Includes support for:

- ✅ Success
- ❌ Error
- ⚠️ Warning
- ℹ️ Info

## 🚀 Features

- Animated snackbar toasts
- Auto-dismiss behavior
- Floating display
- Easy integration

## 📂 Folder Structure

```
lib/
└── common/
    └── toast/
        └── animated_toast.dart
main.dart
pubspec.yaml
```

## 🛠️ Setup

```bash
flutter pub get
flutter run
```

## 📦 Usage

```dart
showAnimatedToast(
  context: context,
  message: "This is a success message!",
  type: ToastType.success,
);
```
