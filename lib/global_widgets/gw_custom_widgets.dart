import 'package:flutter/material.dart';

// [커스텀 위젯 작성 파일]
// 전역의 페이지에서 사용 가능한 위젯입니다.
// View 에 해당하며, Business Logic 생성자에 콜백 함수 파라미터를 넣어주어 처리하세요.

//------------------------------------------------------------------------------
// (페이지 최외곽 프레임 템플릿)
class HoverButton extends StatefulWidget {
  // 버튼 위젯 child
  final Widget child;

  // 버튼 위젯 클릭 콜백
  final VoidCallback onTap;

  // 버튼 호버링시 child 위에 덮을 위젯
  final Widget hoveringWidget;

  const HoverButton({
    super.key,
    required this.child,
    required this.onTap,
    required this.hoveringWidget,
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
            Opacity(
              opacity: _isHovering ? 1.0 : 0.0, // 0.0: 완전 투명, 1.0: 완전 불투명
              child: widget.hoveringWidget,
            ),
          ],
        ),
      ),
    );
  }
}
