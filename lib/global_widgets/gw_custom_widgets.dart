// (external)
import 'package:flutter/foundation.dart';
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

////
// (우클릭 컨텍스트 메뉴 영역 클래스)
class ContextMenuRegion extends StatefulWidget {
  const ContextMenuRegion(this.viewModel, this.child,
      {required super.key, required this.contextMenuRegionItemVoList});

  // 위젯 뷰모델
  final ContextMenuRegionViewModel viewModel;

  //!!!주입 받을 하위 위젯 선언 하기!!!
  final Widget child;

  final List<ContextMenuRegionItemVo> contextMenuRegionItemVoList;

  @override
  ContextMenuRegionState createState() => ContextMenuRegionState();
}

class ContextMenuRegionViewModel {
  ContextMenuRegionViewModel();

// !!!위젯 상태 변수 선언하기!!!
}

class ContextMenuRegionItemVo {
  ContextMenuRegionItemVo(this.menuItemWidget, this.menuItemCallback) {
    // itemUid =
    //     "${menuItemWidget.hashCode.toString()}_${menuItemWidget.hashCode.toString()}";
  }

  Widget menuItemWidget;
  void Function() menuItemCallback;

// late String itemUid;
}

class ContextMenuRegionState extends State<ContextMenuRegion> {
  // Stateful Widget 화면 갱신
  void refresh() {
    setState(() {});
  }

  Offset? _longPressOffset;

  static bool get _longPressEnabled {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return true;
      case TargetPlatform.macOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return false;
    }
  }

  void _onSecondaryTapUp(TapUpDetails details) {
    _show(details.globalPosition);
  }

  void _onLongPressStart(LongPressStartDetails details) {
    _longPressOffset = details.globalPosition;
  }

  void _onLongPress() {
    assert(_longPressOffset != null);
    _show(_longPressOffset!);
    _longPressOffset = null;
  }

  Future<void> _show(Offset position) async {
    final RenderObject overlay =
        Overlay.of(context).context.findRenderObject()!;

    List<PopupMenuItem> popupMenuItemList = [];
    Map popupMenuItemCallbackMap = {};
    int idx = 0;
    for (ContextMenuRegionItemVo contextMenuRegionItemVo
        in widget.contextMenuRegionItemVoList) {
      popupMenuItemList.add(PopupMenuItem(
          value: idx, child: contextMenuRegionItemVo.menuItemWidget));

      popupMenuItemCallbackMap[idx] = contextMenuRegionItemVo.menuItemCallback;
      idx += 1;
    }

    // !!!우클릭 메뉴 외곽을 수정하고 싶으면 이것을 수정하기!!!
    final result = await showMenu(
        context: context,
        position: RelativeRect.fromRect(
            Rect.fromLTWH(position.dx, position.dy, 100, 100),
            Rect.fromLTWH(0, 0, overlay.paintBounds.size.width,
                overlay.paintBounds.size.height)),
        items: popupMenuItemList);

    if (popupMenuItemCallbackMap.containsKey(result)) {
      popupMenuItemCallbackMap[result]();
    }
  }

  @override
  Widget build(BuildContext context) {
    // !!!하위 위젯 작성하기. (widget.viewModel 에서 데이터를 가져와 사용)!!!
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onSecondaryTapUp: _onSecondaryTapUp,
        onLongPress: _longPressEnabled ? _onLongPress : null,
        onLongPressStart: _longPressEnabled ? _onLongPressStart : null,
        child: widget.child);
  }
}
