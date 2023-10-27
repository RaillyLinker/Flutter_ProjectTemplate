// (external)
import 'package:flutter/material.dart';

class HoverButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onClick;
  Color? hoveringColor;

  HoverButton(
      {super.key,
      required this.child,
      required this.onClick,
        required this.hoveringColor});

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (details) => setState(() => _isHovering = true),
      onExit: (details) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onClick,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          color: _isHovering ? widget.hoveringColor : Colors.transparent,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
