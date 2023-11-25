// (external)
import 'package:flutter/cupertino.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
class InputVo {
  const InputVo(
      {required this.child, required this.contextMenuRegionItemVoList});

  // !!!위젯 입력값 선언!!!

  // (래핑할 대상 위젯)
  final Widget child;

  // (컨텍스트 메뉴 리스트)
  final List<ContextMenuRegionItemVo> contextMenuRegionItemVoList;
}

class ContextMenuRegionItemVo {
  ContextMenuRegionItemVo(
      {required this.menuItemWidget, required this.menuItemCallback});

  Widget menuItemWidget;
  void Function() menuItemCallback;
}

class WidgetView extends StatelessWidget {
  const WidgetView({super.key, required this.business, required this.inputVo});

  // [콜백 함수]
  // (위젯을 화면에 draw 할 때의 콜백)
  @override
  Widget build(BuildContext context) {
    return viewWidgetBuild(context: context);
  }

  // [public 변수]
  // (위젯 비즈니스)
  final widget_business.WidgetBusiness business;

  // (위젯 입력값)
  final InputVo inputVo;

  // [뷰 위젯]
  Widget viewWidgetBuild({required BuildContext context}) {
    return StatefulView(
      key: business.statefulGk,
      inputVo: inputVo,
      business: business,
    );
  }
}

class StatefulView extends StatefulWidget {
  const StatefulView(
      {required super.key, required this.inputVo, required this.business});

  // [콜백 함수]
  @override
  StatefulBusiness createState() => StatefulBusiness();

  // [public 변수]
  // (위젯 입력값)
  final InputVo inputVo;

  // (위젯 비즈니스)
  final widget_business.WidgetBusiness business;
}

class StatefulBusiness extends State<StatefulView> {
  StatefulBusiness();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    widget.business.context = context;
    widget.business.widget = widget;
    return WidgetUi.viewWidgetBuild(
        context: context, inputVo: widget.inputVo, business: widget.business);
  }

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }
}

class WidgetUi {
  // [뷰 위젯]
  static Widget viewWidgetBuild(
      {required BuildContext context,
      required InputVo inputVo,
      required widget_business.WidgetBusiness business}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onSecondaryTapUp: (TapUpDetails details) {
          business.show(position: details.globalPosition);
        },
        onLongPress: business.longPressEnabled
            ? () {
                assert(business.longPressOffset != null);
                business.show(position: business.longPressOffset!);
                business.longPressOffset = null;
              }
            : null,
        onLongPressStart: business.longPressEnabled
            ? (LongPressStartDetails details) {
                business.longPressOffset = details.globalPosition;
              }
            : null,
        child: inputVo.child);
  }
}
