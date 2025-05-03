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

  void _showDefaultSuccessToast(BuildContext context) {
    showAnimatedToast(
      context: context,
      message: "This is a SUCCESS message!",
      type: ToastType.success,
    );
  }

  void _showTopWarningToast(BuildContext context) {
    showAnimatedToast(
      context: context,
      message: "This is a WARNING at TOP!",
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
      borderRadius: 25,
    );
  }

  void _showBottomErrorToast(BuildContext context) {
    showAnimatedToast(
      context: context,
      message: "This is an ERROR toast at BOTTOM!",
      type: ToastType.error,
      position: ToastPosition.bottom,
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

  void _showCustomDurationToast(BuildContext context) {
    showAnimatedToast(
      context: context,
      message: "This toast stays for 5 seconds!",
      type: ToastType.info,
      duration: const Duration(seconds: 5),
    );
  }

  void _showLongMessageToast(BuildContext context) {
    showAnimatedToast(
      context: context,
      message: "This is a really long toast message that should wrap onto multiple lines smoothly without any problem. Let’s see how it looks in action!",
      type: ToastType.success,
      position: ToastPosition.bottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animated Toasts")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Wrap(
            spacing: 10,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _showDefaultSuccessToast(context),
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
                onPressed: () => _showBottomErrorToast(context),
                child: const Text('BOTTOM ERROR'),
              ),
              ElevatedButton(
                onPressed: () => _showErrorWithActionToast(context),
                child: const Text('ERROR WITH ACTION'),
              ),
              ElevatedButton(
                onPressed: () => _showCustomDurationToast(context),
                child: const Text('CUSTOM DURATION'),
              ),
              ElevatedButton(
                onPressed: () => _showLongMessageToast(context),
                child: const Text('LONG MESSAGE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
