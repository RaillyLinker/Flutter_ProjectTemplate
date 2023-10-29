import 'package:flutter/material.dart';

// [커스텀 위젯 작성 파일]
// 전역의 페이지에서 사용 가능한 위젯입니다.
// View 에 해당하며, Business Logic 생성자에 콜백 함수 파라미터를 넣어주어 처리하세요.

//------------------------------------------------------------------------------
// (페이지 최외곽 프레임 템플릿)
class HoverButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color? hoveringColor;

  const HoverButton({
    super.key,
    required this.child,
    required this.onTap,
    required this.hoveringColor,
  });

  @override
  HoverButtonState createState() => HoverButtonState();
}

class HoverButtonState extends State<HoverButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (details) => setState(() => _isHovering = true),
      onExit: (details) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            widget.child,
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              color: _isHovering ? widget.hoveringColor : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
