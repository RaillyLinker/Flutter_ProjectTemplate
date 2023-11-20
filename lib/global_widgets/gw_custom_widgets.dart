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

////
// (Dialog 용 종료 애니메이션 샘플)
// 이 위젯을 적용 후 dialogComplete() 를 사용 하면, dialogChild 가 completeChild 로 변환된 이후 종료 됩니다.
class DialogCompleteAnimation extends StatefulWidget {
  const DialogCompleteAnimation(
    this.viewModel, {
    required super.key,
    required this.dialogChild,
    required this.dialogChildSize,
    required this.completeChild,
    required this.completeChildSize,
    required this.completeAnimationDuration,
    required this.completeCloseDuration,
  });

  // 위젯 뷰모델
  final DialogCompleteAnimationViewModel viewModel;

  //!!!주입 받을 하위 위젯 선언 하기!!!
  // 다이얼로그 하위 위젯
  final Widget dialogChild;
  final Size dialogChildSize;

  // 완료시 표시될 하위 위젯
  final Widget completeChild;
  final Size completeChildSize;

  // 변환 애니메이션 속도
  final Duration completeAnimationDuration;

  // 다이얼로그 종료 속도(변환 애니메이션보단 길어야 애니메이션을 감상 가능)
  final Duration completeCloseDuration;

  @override
  DialogCompleteAnimationState createState() => DialogCompleteAnimationState();
}

class DialogCompleteAnimationViewModel {
  DialogCompleteAnimationViewModel();

  // !!!위젯 상태 변수 선언하기!!!

  // 다이얼로그 작업 완료 여부
  bool isComplete = false;
}

class DialogCompleteAnimationState extends State<DialogCompleteAnimation> {
  // Stateful Widget 화면 갱신
  void refresh() {
    setState(() {});
  }

  // (다이얼로그 완료)
  Future<void> dialogComplete() async {
    widget.viewModel.isComplete = true;
    refresh();

    // 애니메이션의 지속 시간만큼 지연
    await Future.delayed(widget.completeCloseDuration);

    // 다이얼로그 닫기
    if (!context.mounted) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    // !!!하위 위젯 작성하기. (widget.viewModel 에서 데이터를 가져와 사용)!!!
    return AnimatedContainer(
      width: widget.viewModel.isComplete
          ? widget.completeChildSize.width
          : widget.dialogChildSize.width,
      height: widget.viewModel.isComplete
          ? widget.completeChildSize.height
          : widget.dialogChildSize.height,
      curve: Curves.fastOutSlowIn,
      duration: widget.completeAnimationDuration,
      child: widget.viewModel.isComplete
          ? widget.completeChild
          : widget.dialogChild,
    );
  }
}
