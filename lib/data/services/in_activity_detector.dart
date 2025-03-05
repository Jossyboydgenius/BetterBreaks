import 'dart:async';
import 'package:flutter/material.dart';

class InActivityDetector extends StatefulWidget {
  final Widget child;
  final Duration timeout;

  const InActivityDetector({
    super.key,
    required this.child,
    this.timeout = const Duration(minutes: 30),
  });

  @override
  State<InActivityDetector> createState() => _InActivityDetectorState();
}

class _InActivityDetectorState extends State<InActivityDetector> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _resetTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer(widget.timeout, _handleInactivity);
  }

  void _handleInactivity() {
    // Handle inactivity here, e.g., log out the user
    // For now, we'll just print a message
    debugPrint('User inactive for ${widget.timeout.inMinutes} minutes');
    
    // You can navigate to the login screen or show a dialog
    // NavigationService.pushReplacementNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _resetTimer,
      onPanDown: (_) => _resetTimer(),
      onScaleStart: (_) => _resetTimer(),
      child: widget.child,
    );
  }
} 