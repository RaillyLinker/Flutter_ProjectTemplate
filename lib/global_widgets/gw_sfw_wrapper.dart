// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.
// 기본 Stateful Widget 의 Wrapper 클래스를 여기에 저장하여 사용합니다.

// -----------------------------------------------------------------------------
// (리플레시 래퍼 위젯)
class SfwRefreshWrapper extends StatefulWidget {
  const SfwRefreshWrapper(
      {required super.key,
      this.widgetInit,
      required this.widgetBuild,
      this.widgetDispose});

  final void Function(BuildContext context)? widgetInit;
  final Widget Function(BuildContext context) widgetBuild;
  final void Function(BuildContext context)? widgetDispose;

  // [콜백 함수]
  @override
  SfwRefreshWrapperState createState() => SfwRefreshWrapperState();
}

class SfwRefreshWrapperState extends State<SfwRefreshWrapper> {
  @override
  void initState() {
    super.initState();
    if (widget.widgetInit != null) {
      widget.widgetInit!(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.widgetBuild(context);
  }

  @override
  void dispose() {
    if (widget.widgetDispose != null) {
      widget.widgetDispose!(context);
    }
    super.dispose();
  }

  void refreshUi() {
    setState(() {});
  }
}

////
// (컨택스트 메뉴 영역 위젯)
class SfwContextMenuRegion extends StatefulWidget {
  const SfwContextMenuRegion(
      {required super.key,
      required this.child,
      required this.contextMenuRegionItemVoList});

  // !!!외부 입력 변수 선언 하기!!!
  // (래핑할 대상 위젯)
  final Widget child;

  // (컨텍스트 메뉴 리스트)
  final List<ContextMenuRegionItemVo> contextMenuRegionItemVoList;

  // [콜백 함수]
  @override
  SfwContextMenuRegionState createState() => SfwContextMenuRegionState();
}

class SfwContextMenuRegionState extends State<SfwContextMenuRegion> {
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return getScreenWidget();
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

  //----------------------------------------------------------------------------
  // !!!위젯 변수를 저장 하세요.!!!
  // [public 변수]
  Offset? longPressOffset;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!위젯 함수를 작성 하세요.!!!
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

  // [private 함수]

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget() {
    // !!!위젯 화면을 작성 하세요.!!!

    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onSecondaryTapUp: (TapUpDetails details) {
          show(position: details.globalPosition);
        },
        onLongPress: longPressEnabled
            ? () {
                assert(longPressOffset != null);
                show(position: longPressOffset!);
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
// (Gif Widget)
class SfwGifWidget extends StatefulWidget {
  const SfwGifWidget({required super.key, required this.gifImage});

  // !!!외부 입력 변수 선언 하기!!!
  // (gif 이미지 객체)
  final ImageProvider gifImage;

  // [콜백 함수]
  @override
  SfwGifWidgetState createState() => SfwGifWidgetState();
}

class SfwGifWidgetState extends State<SfwGifWidget>
    with SingleTickerProviderStateMixin {
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return getScreenWidget();
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

  //----------------------------------------------------------------------------
  // !!!위젯 변수를 저장 하세요.!!!
  // [public 변수]
  // (Gif 컨트롤러)
  late GifController dialogSpinnerGifController;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!위젯 함수를 작성 하세요.!!!
  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // [private 함수]

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget() {
    // !!!위젯 화면을 작성 하세요.!!!

    return Gif(
      image: widget.gifImage,
      controller: dialogSpinnerGifController,
      placeholder: (context) => const Text(''),
      onFetchCompleted: () {},
    );
  }
}
