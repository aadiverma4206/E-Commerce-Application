import 'package:flutter/material.dart';

class AnimatedTile extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;

  const AnimatedTile({super.key, required this.onTap, required this.child});

  @override
  State<AnimatedTile> createState() => _AnimatedTileState();
}

class _AnimatedTileState extends State<AnimatedTile>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  Color _backgroundColor = Colors.transparent;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95;
      _backgroundColor = Colors.grey.shade700; // softer and more visible
    });
  }

  void _onTapUp(TapUpDetails details) async {
    setState(() {
      _scale = 1.0;
      _backgroundColor = Colors.transparent;
    });
    await Future.delayed(const Duration(milliseconds: 180));
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
      _backgroundColor = Colors.transparent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        color: _backgroundColor,
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: widget.child,
        ),
      ),
    );
  }
}
