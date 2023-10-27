// (external)
import 'package:flutter/material.dart';

// [커스텀 위젯 작성 파일]
// 원하는 커스텀 위젯을 모아두고 사용하면 됩니다.

//------------------------------------------------------------------------------
// (호버링하면 커서 모양과 색상이 변하는 버튼 위젯)
// 기존에 GestureDetector 위젯 위치에 사용하면 됩니다.(onTap 만 있는 GestureDetector 와 동일)
class HoverButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color? hoveringColor;

  const HoverButton(
      {super.key,
      required this.child,
      required this.onTap,
      this.hoveringColor = Colors.grey});

  @override
  HoverButtonState createState() => HoverButtonState();
}

class HoverButtonState extends State<HoverButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (details) => setState(() => _isHovering = true),
      onExit: (details) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 0),
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
