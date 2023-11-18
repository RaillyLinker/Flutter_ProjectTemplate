// (external)
import 'package:flutter/material.dart';

// [커스텀 위젯 작성 파일]
// 전역의 페이지에서 사용 가능한 위젯입니다.
// View 에 해당하며, Business Logic 생성자에 콜백 함수 파라미터를 넣어주어 처리하세요.

//------------------------------------------------------------------------------
// 호버 리스트 타일 래퍼
class HoverListTileWrapper extends StatefulWidget {
  const HoverListTileWrapper(this.viewModel, this.listTileChild,
      {required super.key});

  final HoverListTileWrapperViewModel viewModel;
  final Widget listTileChild;

  @override
  HoverListTileWrapperState createState() => HoverListTileWrapperState();
}

class HoverListTileWrapperViewModel {
  HoverListTileWrapperViewModel(this.onRouteListItemClick);

  bool isHovering = false;
  void Function() onRouteListItemClick;
}

class HoverListTileWrapperState extends State<HoverListTileWrapper> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      // 커서 변경 및 호버링 상태 변경
      cursor: SystemMouseCursors.click,
      onEnter: (details) => setState(() => widget.viewModel.isHovering = true),
      onExit: (details) => setState(() => widget.viewModel.isHovering = false),
      child: GestureDetector(
        // 클릭시 제스쳐 콜백
        onTap: () {
          widget.viewModel.onRouteListItemClick();
        },
        child: Container(
          color: widget.viewModel.isHovering
              ? Colors.blue.withOpacity(0.2)
              : Colors.white,
          child: widget.listTileChild,
        ),
      ),
    );
  }
}
