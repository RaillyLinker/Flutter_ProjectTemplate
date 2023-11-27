// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// (inner Folder)
import 'widget_view.dart' as widget_view;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class WidgetBusiness {
  // [콜백 함수]
  // (Stateful Widget initState)
  void initState(widget_view.StatefulState statefulState) {}

  // (Stateful Widget dispose)
  void dispose(widget_view.StatefulState statefulState) {}

  // [public 변수]
  // (위젯 Context)
  late BuildContext context;

  // (위젯 입력값)
  late widget_view.InputVo inputVo;

  Offset? longPressOffset;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  late VoidCallback refreshUi;

  // (우클릭 메뉴 보이기)
  Future<void> show({required Offset position}) async {
    final RenderObject overlay =
        Overlay.of(context).context.findRenderObject()!;

    List<PopupMenuItem> popupMenuItemList = [];
    Map popupMenuItemCallbackMap = {};
    int idx = 0;
    for (widget_view.ContextMenuRegionItemVo contextMenuRegionItemVo
        in inputVo.contextMenuRegionItemVoList) {
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

  // (길게 누르기를 할지 우클릭을 할지 여부)
  bool get longPressEnabled {
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

// [private 함수]
}
