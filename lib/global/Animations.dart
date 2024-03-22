import 'package:flutter/material.dart';
import 'dart:math' as math;

class FloatingWidget extends StatefulWidget {
  final Widget child;
  final double seed;
  final Duration duration;

  const FloatingWidget({required this.child, required this.seed, required this.duration});

  @override
  _FloatingWidgetState createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<FloatingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late double _rotationX;
  late double _rotationY;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      
    )..addListener(_updateRotations)
    ..repeat(reverse: true);
    _randomizeRotations();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateRotations() {
    setState(() {
      _rotationX = math.sin(_controller.value * math.pi * 2) * 0.2;
      _rotationY = math.cos(_controller.value * math.pi * 2) * 0.2;
    });
  }

  void _randomizeRotations() {
    _rotationX = widget.seed * 0.3 - 0.15;
    _rotationY = widget.seed * 0.3 - 0.15;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
         return Transform(
          transform: Matrix4.identity()
          
            ..setEntry(3, 2, 0.001) // Perspective effect
            ..rotateX(_rotationX)
            ..rotateY(_rotationY),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}



class BgAnim extends StatefulWidget {
  Widget? child;
  BgAnim(this.child, {super.key});
  @override
  _BgAnim createState() => _BgAnim();
}

class _BgAnim extends State<BgAnim> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20), // Adjust the duration as needed
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        double dx = math.sin(_controller.value * 2 * math.pi) * 25; 
        double dy = math.cos(_controller.value * 2 * math.pi) * 25; 

        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/stars.png'),
              fit: BoxFit.cover,
            ),
          ),
          transform: Matrix4.translationValues(dx, dy, 0),
          child: widget.child,
        );
      },
    );
  }
}
