import 'dart:async';

import 'package:flutter/material.dart';

/// Reusable splash screen widget.
///
/// Provide an [onFinish] callback to navigate away when the splash completes.
class SplashScreen extends StatefulWidget {
  final Duration duration;
  final VoidCallback? onFinish;
  final Widget? child;

  const SplashScreen({super.key, this.duration = const Duration(seconds: 2), this.onFinish, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.duration, () {
      widget.onFinish?.call();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: widget.child ?? Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              FlutterLogo(size: 96),
              SizedBox(height: 16),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
