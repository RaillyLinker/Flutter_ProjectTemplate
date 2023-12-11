// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gif/gif.dart';

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.
// 기본 Stateful Widget 의 Wrapper 클래스를 여기에 저장하여 사용합니다.

// -----------------------------------------------------------------------------
// (리플레시 래퍼 위젯)
class SfwRefreshWrapper extends StatefulWidget {
  const SfwRefreshWrapper(
      {required super.key, required this.childWidgetBuilder});

  // !!!외부 입력 변수 선언 하기!!!
  final Widget Function(BuildContext context) childWidgetBuilder;

  // [콜백 함수]
  @override
  SfwRefreshWrapperState createState() => SfwRefreshWrapperState();
}

class SfwRefreshWrapperState extends State<SfwRefreshWrapper> {
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return getScreenWidget(context: context);
  }

  @override
  void initState() {
    super.initState();
    // !!!initState 작성!!!
  }

  @override
  void dispose() {
    // !!!dispose 작성!!!
    super.dispose();
  }

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // [private 함수]

  //----------------------------------------------------------------------------
  // [public 변수]

  // [private 변수]

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget({required BuildContext context}) {
    return widget.childWidgetBuilder(context);
  }
}

// (컨택스트 메뉴 영역 위젯)
class SfwContextMenuRegion extends StatefulWidget {
  const SfwContextMenuRegion(
      {required this.globalKey,
      required this.child,
      required this.contextMenuRegionItemVoList})
      : super(key: globalKey);

  // [콜백 함수]
  @override
  SfwContextMenuRegionState createState() => SfwContextMenuRegionState();

  // [public 변수]
  final GlobalKey<SfwContextMenuRegionState> globalKey;

  // !!!외부 입력 변수 선언 하기!!!
  // (래핑할 대상 위젯)
  final Widget child;

  // (컨텍스트 메뉴 리스트)
  final List<ContextMenuRegionItemVo> contextMenuRegionItemVoList;

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context,
      required SfwContextMenuRegionState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onSecondaryTapUp: (TapUpDetails details) {
          currentState.show(position: details.globalPosition);
        },
        onLongPress: globalKey.currentState!.longPressEnabled
            ? () {
                assert(currentState.longPressOffset != null);
                globalKey.currentState
                    ?.show(position: globalKey.currentState!.longPressOffset!);
                currentState.longPressOffset = null;
              }
            : null,
        onLongPressStart: globalKey.currentState!.longPressEnabled
            ? (LongPressStartDetails details) {
                currentState.longPressOffset = details.globalPosition;
              }
            : null,
        child: child);
  }
}

class SfwContextMenuRegionState extends State<SfwContextMenuRegion> {
  SfwContextMenuRegionState();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return widget.widgetUiBuild(context: context, currentState: this);
  }

  @override
  void initState() {
    super.initState();
    // !!!initState 작성!!!
  }

  @override
  void dispose() {
    // !!!dispose 작성!!!
    super.dispose();
  }

  // [public 변수]
  Offset? longPressOffset;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // (우클릭 메뉴 보이기)
  Future<void> show({required Offset position}) async {
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
}

class ContextMenuRegionItemVo {
  ContextMenuRegionItemVo(
      {required this.menuItemWidget, required this.menuItemCallback});

  Widget menuItemWidget;
  void Function() menuItemCallback;
}

// (Gif Widget)
class SfwGifWidget extends StatefulWidget {
  const SfwGifWidget({required this.globalKey, required this.gifImage})
      : super(key: globalKey);

  // [콜백 함수]
  @override
  SfwGifWidgetState createState() => SfwGifWidgetState();

  // [public 변수]
  final GlobalKey<SfwGifWidgetState> globalKey;

  // !!!외부 입력 변수 선언 하기!!!
  final ImageProvider gifImage;

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context,
      required SfwGifWidgetState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return Gif(
      image: gifImage,
      controller: currentState.dialogSpinnerGifController,
      placeholder: (context) => const Text(''),
      onFetchCompleted: () {},
    );
  }
}

class SfwGifWidgetState extends State<SfwGifWidget>
    with SingleTickerProviderStateMixin {
  SfwGifWidgetState();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return widget.widgetUiBuild(context: context, currentState: this);
  }

  @override
  void initState() {
    super.initState();
    // !!!initState 작성!!!
    dialogSpinnerGifController = GifController(vsync: this);
    dialogSpinnerGifController.repeat(
        period: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    // !!!dispose 작성!!!
    dialogSpinnerGifController.dispose();

    super.dispose();
  }

  // [public 변수]
  // (Gif 컨트롤러)
  late GifController dialogSpinnerGifController;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }
}
