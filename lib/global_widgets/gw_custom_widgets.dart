// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

////
// (우클릭 컨텍스트 메뉴 영역 클래스)
class ContextMenuRegion extends StatefulWidget {
  const ContextMenuRegion(
      {super.key,
      required this.business,
      required this.child,
      required this.contextMenuRegionItemVoList});

  // [위젯 관련 변수] - State 의 setState() 를 하면 초기화 됩니다.
  // (위젯 비즈니스)
  final ContextMenuRegionBusiness business;

  // (래핑할 대상 위젯)
  final Widget child;

  // (컨텍스트 메뉴 리스트)
  final List<ContextMenuRegionItemVo> contextMenuRegionItemVoList;

  // [내부 함수]
  @override
  // ignore: no_logic_in_create_state
  ContextMenuRegionBusiness createState() => business;
}

class ContextMenuRegionBusiness extends State<ContextMenuRegion> {
  ContextMenuRegionBusiness();

  // [위젯 관련 변수] - State 내에서 상태가 유지 됩니다.
  Offset? longPressOffset;

  // [외부 공개 함수]
  // (Stateful Widget 화면 갱신)
  void refresh() {
    setState(() {});
  }

  // [내부 함수]
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onSecondaryTapUp: (TapUpDetails details) {
          _show(details.globalPosition);
        },
        onLongPress: longPressEnabled
            ? () {
                assert(longPressOffset != null);
                _show(longPressOffset!);
                longPressOffset = null;
              }
            : null,
        onLongPressStart: longPressEnabled
            ? (LongPressStartDetails details) {
                longPressOffset = details.globalPosition;
              }
            : null,
        child: widget.child);
  }
}

class ContextMenuRegionItemVo {
  ContextMenuRegionItemVo(
      {required this.menuItemWidget, required this.menuItemCallback});

  Widget menuItemWidget;
  void Function() menuItemCallback;
}

////
// (Dialog 용 종료 애니메이션 샘플)
// 이 위젯을 적용 후 dialogComplete() 를 사용 하면, dialogChild 가 completeChild 로 변환된 이후 종료 됩니다.
class DialogCompleteAnimation extends StatefulWidget {
  const DialogCompleteAnimation(
      {super.key,
      required this.business,
      required this.dialogChild,
      required this.dialogChildSize,
      required this.completeChild,
      required this.completeChildSize,
      required this.completeAnimationDuration,
      required this.completeCloseDuration});

  // [위젯 관련 변수] - State 의 setState() 를 하면 초기화 됩니다.
  // (위젯 비즈니스)
  final DialogCompleteAnimationBusiness business;

  // (다이얼로그 위젯 정보)
  final Widget dialogChild;
  final Size dialogChildSize;

  // (완료시 표시될 위젯 정보)
  final Widget completeChild;
  final Size completeChildSize;

  // (변환 애니메이션 속도)
  final Duration completeAnimationDuration;

  // (다이얼로그 종료 속도 - 변환 애니메이션보단 길어야 애니메이션을 감상 가능)
  final Duration completeCloseDuration;

  // [내부 함수]
  @override
  // ignore: no_logic_in_create_state
  DialogCompleteAnimationBusiness createState() => business;
}

class DialogCompleteAnimationBusiness extends State<DialogCompleteAnimation> {
  DialogCompleteAnimationBusiness();

  // [위젯 관련 변수] - State 내에서 상태가 유지 됩니다.
  // (다이얼로그 작업 완료 여부)
  bool isComplete = false;

  // [외부 공개 함수]
  // (Stateful Widget 화면 갱신)
  void refresh() {
    setState(() {});
  }

  // (다이얼로그 완료)
  Future<void> dialogComplete() async {
    isComplete = true;
    refresh();

    // 애니메이션의 지속 시간만큼 지연
    await Future.delayed(widget.completeCloseDuration);

    // 다이얼로그 닫기
    if (!context.mounted) return;
    context.pop();
  }

  // [내부 함수]
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isComplete
          ? widget.completeChildSize.width
          : widget.dialogChildSize.width,
      height: isComplete
          ? widget.completeChildSize.height
          : widget.dialogChildSize.height,
      curve: Curves.fastOutSlowIn,
      duration: widget.completeAnimationDuration,
      child: isComplete ? widget.completeChild : widget.dialogChild,
    );
  }
}
