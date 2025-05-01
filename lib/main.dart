import 'package:flutter/material.dart';
import 'common/toast/animated_toast.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Toast Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ToastDemoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ToastDemoPage extends StatelessWidget {
  const ToastDemoPage({super.key});

  void _showDefaultToast(BuildContext context) {
    showAnimatedToast(
      context: context,
      message: "This is a SUCCESS message!",
      type: ToastType.success,
    );
  }

  void _showTopWarningToast(BuildContext context) {
    showAnimatedToast(
      context: context,
      message: "This is a WARNING message at TOP!",
      type: ToastType.warning,
      position: ToastPosition.top,
    );
  }

  void _showCenterCustomToast(BuildContext context) {
    showAnimatedToast(
      context: context,
      message: "This is a CUSTOM styled CENTER toast!",
      type: ToastType.info,
      position: ToastPosition.center,
      backgroundColor: Colors.deepPurple,
      textColor: Colors.yellowAccent,
      customIcon: Icons.star,
      borderRadius: 20,
    );
  }

  void _showErrorWithActionToast(BuildContext context) {
    showAnimatedToast(
      context: context,
      message: "Item deleted",
      type: ToastType.error,
      actionText: "UNDO",
      onActionTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Undo tapped!")),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animated Toasts")),
      body: Center(
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ElevatedButton(
              onPressed: () => _showDefaultToast(context),
              child: const Text('DEFAULT SUCCESS'),
            ),
            ElevatedButton(
              onPressed: () => _showTopWarningToast(context),
              child: const Text('TOP WARNING'),
            ),
            ElevatedButton(
              onPressed: () => _showCenterCustomToast(context),
              child: const Text('CENTER CUSTOM'),
            ),
            ElevatedButton(
              onPressed: () => _showErrorWithActionToast(context),
              child: const Text('ERROR WITH ACTION'),
            ),
          ],
        ),
      ),
    );
  }
}
