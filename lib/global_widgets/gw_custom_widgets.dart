// (external)
import 'package:flutter/material.dart';

// [커스텀 위젯 작성 파일]
// 전역의 페이지에서 사용 가능한 위젯입니다.
// View 에 해당하며, Business Logic 생성자에 콜백 함수 파라미터를 넣어주어 처리하세요.

//------------------------------------------------------------------------------
// (호버 리스트 타일 래퍼)
class HoverListTileWrapper extends StatefulWidget {
  const HoverListTileWrapper(
      {super.key, required this.business, required this.listTileChild});

  // [위젯 관련 변수] - State 의 setState() 를 하면 초기화 됩니다.
  // (위젯 비즈니스)
  final HoverListTileWrapperBusiness business;

  // (리스트 아이템 위젯)
  final Widget listTileChild;

  // [내부 함수]
  @override
  // ignore: no_logic_in_create_state
  HoverListTileWrapperBusiness createState() => business;
}

class HoverListTileWrapperBusiness extends State<HoverListTileWrapper> {
  HoverListTileWrapperBusiness({required this.onRouteListItemClick});

  // [위젯 관련 변수] - State 내에서 상태가 유지 됩니다.
  // (현재 호버링 중인지 여부)
  bool isHovering = false;

  // (리스트 아이템 클릭 콜백)
  void Function() onRouteListItemClick;

  // [외부 공개 함수]
  // (Stateful Widget 화면 갱신)
  void refresh() {
    setState(() {});
  }

  // [내부 함수]
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      // 커서 변경 및 호버링 상태 변경
      cursor: SystemMouseCursors.click,
      onEnter: (details) => setState(() => isHovering = true),
      onExit: (details) => setState(() => isHovering = false),
      child: GestureDetector(
        // 클릭시 제스쳐 콜백
        onTap: () {
          onRouteListItemClick();
        },
        child: Container(
          color: isHovering ? Colors.blue.withOpacity(0.2) : Colors.white,
          child: widget.listTileChild,
        ),
      ),
    );
  }
}
