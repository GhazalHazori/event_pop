import 'dart:math' as Math;

import 'package:flutter/material.dart';

class MultiDotLoader extends StatefulWidget {
  final double size;
  final Color color;
  final int dotCount;
  const MultiDotLoader({
    Key? key,
    this.size = 50,
    this.color = Colors.blue,
    this.dotCount = 3,
  }) : super(key: key);

  @override
  State<MultiDotLoader> createState() => _MultiDotLoaderState();
}

class _MultiDotLoaderState extends State<MultiDotLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          List<Widget> dots = [];
          final double angleStep = 2 * 3.1416 / widget.dotCount;
          final double radius = widget.size * 0.4;

          for (int i = 0; i < widget.dotCount; i++) {
            final double angle = _controller.value * 2 * 3.1416 + angleStep * i;
            final double dx = radius * Math.cos(angle);
            final double dy = radius * Math.sin(angle);

            dots.add(
              Transform.translate(
                offset: Offset(dx, dy),
                child: Container(
                  width: widget.size * 0.15,
                  height: widget.size * 0.15,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }

          return Stack(
            alignment: Alignment.center,
            children: dots,
          );
        },
      ),
    );
  }
}
