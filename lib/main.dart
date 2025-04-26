
import 'package:flutter/material.dart';
import 'common/toast/animated_toast.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Toast Demo',
      home: const ToastDemoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ToastDemoPage extends StatelessWidget {
  const ToastDemoPage({super.key});

  void _showToast(BuildContext context, ToastType type) {
    showAnimatedToast(
      context: context,
      message: "This is a ${type.name} message!",
      type: type,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animated Toasts")),
      body: Center(
        child: Wrap(
          spacing: 10,
          children: ToastType.values.map((type) {
            return ElevatedButton(
              onPressed: () => _showToast(context, type),
              child: Text(type.name.toUpperCase()),
            );
          }).toList(),
        ),
      ),
    );
  }
}
