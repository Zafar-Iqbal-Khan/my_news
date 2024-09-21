import 'dart:math';

import 'package:flutter/material.dart';

class Loading {
  static dialog(BuildContext context) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.center,
          child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: const LoadingDialog()),
        );
      });
}

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({super.key});

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 4 * pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.duration = const Duration(seconds: 2);
        _controller.repeat(reverse: true);
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset('assets/images/mynews.jpeg'),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
