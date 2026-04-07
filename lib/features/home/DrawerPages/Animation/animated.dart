import 'package:flutter/material.dart';

class AnimatedTile extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;

  const AnimatedTile({
    super.key,
    required this.onTap,
    required this.child,
  });

  @override
  State<AnimatedTile> createState() => _AnimatedTileState();
}

class _AnimatedTileState extends State<AnimatedTile> {
  double _scale = 1.0;
  Color _backgroundColor = Colors.transparent;
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    if (_isPressed) return;
    setState(() {
      _isPressed = true;
      _scale = 0.96;
      _backgroundColor = Colors.black.withOpacity(0.1);
    });
  }

  void _onTapUp(TapUpDetails details) async {
    if (!_isPressed) return;
    setState(() {
      _scale = 1.0;
      _backgroundColor = Colors.transparent;
    });
    await Future.delayed(const Duration(milliseconds: 120));
    if (mounted) widget.onTap();
    _isPressed = false;
  }

  void _onTapCancel() {
    if (!_isPressed) return;
    setState(() {
      _scale = 1.0;
      _backgroundColor = Colors.transparent;
    });
    _isPressed = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          child: widget.child,
        ),
      ),
    );
  }
}