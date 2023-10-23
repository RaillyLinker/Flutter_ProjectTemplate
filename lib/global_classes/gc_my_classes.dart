// (external)
import 'package:sync/semaphore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// [전역 클래스 선언 파일]
// 프로그램 전역에서 사용할 Class 를 선언하는 파일입니다.

// -----------------------------------------------------------------------------
// (스레드 합류 클래스)
// 나눠진 스레드를 하나의 시점에 모을 때 사용합니다.
// 사용법 :
// var threadConfluenceObj = ThreadConfluenceObj(2, () {
//     print("Threads all Complete!");
// });
// 위와 같이 먼저 합류 객체를 만듭니다.
// 첫번째 파라미터는 합류가 이루어지는 비동기 작업 개수이고,
// 두번째 파라미터는 합류가 이루어진 시점에 동작하는 콜백입니다.
// 위 객체를 해석하자면,
// 2 개의 스레드가 합류되면 Threads all Complete! 라는 문구를 출력한다는 것입니다.
// 합류할 각 스레드들은 비동기 작업이 끝난 후, 작업이 끝났음을 합류 객체에게 알려주기 위하여,
// threadConfluenceObj.threadComplete();
// 를 해줍니다.
// 여기선 threadConfluenceObj.threadComplete(); 가 2번 동작하면 합류 객체에 넘겨준 콜백이 실행되는 것입니다.
class ThreadConfluenceObj {
  late int numberOfThreadsBeingJoined;
  late final void Function() _onComplete;

  int _threadAccessCount = 0;
  final Semaphore _threadAccessCountSemaphore = Semaphore(1);

  ThreadConfluenceObj(this.numberOfThreadsBeingJoined, this._onComplete);

  void threadComplete() {
    () async {
      _threadAccessCountSemaphore.acquire();
      if (_threadAccessCount < 0) {
        // 오버플로우 방지
        return;
      }

      // 스레드 접근 카운트 +1
      ++_threadAccessCount;

      if (_threadAccessCount != numberOfThreadsBeingJoined) {
        // 접근 카운트가 합류 총 개수를 넘었을 때 or 접근 카운트가 합류 총 개수에 미치지 못했을 때
        _threadAccessCountSemaphore.release();
      } else {
        // 접근 카운트가 합류 총 개수에 다다랐을 때
        _threadAccessCountSemaphore.release();
        _onComplete();
      }
    }();
  }
}

// (AnimatedSwitcher 설정)
class AnimatedSwitcherConfig {
  Duration duration;
  Duration? reverseDuration;
  Curve switchInCurve;
  Curve switchOutCurve;
  AnimatedSwitcherTransitionBuilder transitionBuilder;
  AnimatedSwitcherLayoutBuilder layoutBuilder;

  AnimatedSwitcherConfig(this.duration,
      {this.reverseDuration,
      this.switchInCurve = Curves.linear,
      this.switchOutCurve = Curves.linear,
      this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
      this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder});

  AnimatedSwitcherConfig clone() {
    return AnimatedSwitcherConfig(duration,
        reverseDuration: reverseDuration,
        switchInCurve: switchInCurve,
        switchOutCurve: switchOutCurve,
        transitionBuilder: transitionBuilder,
        layoutBuilder: layoutBuilder);
  }
}

// (우클릭 컨텍스트 메뉴 영역 클래스)
class ContextMenuRegionItemVo {
  Widget menuItemWidget;
  void Function() menuItemCallback;

  late String itemUid;

  ContextMenuRegionItemVo(this.menuItemWidget, this.menuItemCallback) {
    String menuItemWidgetCode = menuItemWidget.hashCode.toString();
    String menuItemCallbackCode = menuItemWidget.hashCode.toString();
    itemUid = "${menuItemWidgetCode}_$menuItemCallbackCode";
  }
}

class ContextMenuRegion extends StatefulWidget {
  ContextMenuRegion(
      {super.key,
      required this.child,
      required this.contextMenuRegionItemVoList});

  final Widget child;

  final List<ContextMenuRegionItemVo> contextMenuRegionItemVoList;

  final _ContextMenuRegionState _contextMenuRegionState =
      _ContextMenuRegionState();

  @override
  // ignore: no_logic_in_create_state
  State<ContextMenuRegion> createState() => _contextMenuRegionState;
}

class _ContextMenuRegionState extends State<ContextMenuRegion> {
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
    for (ContextMenuRegionItemVo contextMenuRegionItemVo
        in widget.contextMenuRegionItemVoList) {
      popupMenuItemList.add(PopupMenuItem(
          value: contextMenuRegionItemVo.itemUid,
          child: contextMenuRegionItemVo.menuItemWidget));

      popupMenuItemCallbackMap[contextMenuRegionItemVo.itemUid] =
          contextMenuRegionItemVo.menuItemCallback;
    }

    // !!!우클릭 메뉴 외곽을 수정하고 싶으면 이것을 수정하기!!
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
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onSecondaryTapUp: _onSecondaryTapUp,
        onLongPress: _longPressEnabled ? _onLongPress : null,
        onLongPressStart: _longPressEnabled ? _onLongPressStart : null,
        child: widget.child);
  }
}
