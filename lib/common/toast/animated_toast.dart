import 'package:flutter/material.dart';

enum ToastType { success, error, warning, info }
enum ToastPosition { top, center, bottom }

OverlayEntry? _currentToast;

void showAnimatedToast({
  required BuildContext context,
  required String message,
  required ToastType type,
  ToastPosition position = ToastPosition.bottom,
  Color? backgroundColor,
  Color? textColor,
  IconData? customIcon,
  double borderRadius = 12.0,
  String? actionText,
  VoidCallback? onActionTap,
  Duration duration = const Duration(seconds: 3),
}) {
  _currentToast?.remove();

  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => _AnimatedToast(
      message: message,
      type: type,
      position: position,
      backgroundColor: backgroundColor,
      textColor: textColor,
      customIcon: customIcon,
      borderRadius: borderRadius,
      actionText: actionText,
      onActionTap: onActionTap,
      duration: duration,
    ),
  );

  _currentToast = overlayEntry;
  overlay.insert(overlayEntry);

  Future.delayed(duration + const Duration(milliseconds: 300), () {
    if (_currentToast == overlayEntry) {
      _currentToast?.remove();
      _currentToast = null;
    }
  });
}

class _AnimatedToast extends StatefulWidget {
  final String message;
  final ToastType type;
  final ToastPosition position;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? customIcon;
  final double borderRadius;
  final String? actionText;
  final VoidCallback? onActionTap;
  final Duration duration;

  const _AnimatedToast({
    Key? key,
    required this.message,
    required this.type,
    required this.position,
    this.backgroundColor,
    this.textColor,
    this.customIcon,
    this.borderRadius = 12.0,
    this.actionText,
    this.onActionTap,
    required this.duration,
  }) : super(key: key);

  @override
  State<_AnimatedToast> createState() => _AnimatedToastState();
}

class _AnimatedToastState extends State<_AnimatedToast> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _defaultBackgroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (widget.type) {
      case ToastType.success:
        return isDark ? Colors.greenAccent.shade700 : Colors.green;
      case ToastType.error:
        return isDark ? Colors.redAccent.shade700 : Colors.red;
      case ToastType.warning:
        return isDark ? Colors.orangeAccent.shade700 : Colors.orange;
      case ToastType.info:
        return isDark ? Colors.lightBlueAccent.shade700 : Colors.blue;
    }
  }

  IconData _defaultIcon() {
    switch (widget.type) {
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.error:
        return Icons.error;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
        return Icons.info;
    }
  }

  double _getVerticalPosition(BuildContext context) {
    switch (widget.position) {
      case ToastPosition.top:
        return MediaQuery.of(context).padding.top + 50;
      case ToastPosition.center:
        return MediaQuery.of(context).size.height / 2 - 30;
      case ToastPosition.bottom:
        return MediaQuery.of(context).size.height - 150;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.position == ToastPosition.top || widget.position == ToastPosition.center
          ? _getVerticalPosition(context)
          : null,
      bottom: widget.position == ToastPosition.bottom ? 50 : null,
      left: 24,
      right: 24,
      child: SlideTransition(
        position: _offsetAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? _defaultBackgroundColor(context),
                borderRadius: BorderRadius.circular(widget.borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.customIcon ?? _defaultIcon(),
                    color: widget.textColor ?? Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      widget.message,
                      style: TextStyle(color: widget.textColor ?? Colors.white),
                    ),
                  ),
                  if (widget.actionText != null && widget.onActionTap != null)
                    TextButton(
                      onPressed: widget.onActionTap,
                      child: Text(
                        widget.actionText!,
                        style: TextStyle(
                          color: widget.textColor ?? Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
