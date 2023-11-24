// (external)
import 'package:flutter/cupertino.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (우클릭 컨텍스트 메뉴 영역 클래스)
class WidgetView extends StatefulWidget {
  WidgetView(
      {super.key,
      required widget_business.WidgetBusiness business,
      required this.child,
      required this.contextMenuRegionItemVoList})
      : _business = business {
    _business.view = this;
  }

  // [콜백 함수]
  @override
  // ignore: no_logic_in_create_state
  widget_business.WidgetBusiness createState() => _business;

  // [public 변수]
  // (컨텍스트 메뉴 리스트)
  final List<ContextMenuRegionItemVo> contextMenuRegionItemVoList;

  // [private 변수]
  // (위젯 비즈니스)
  final widget_business.WidgetBusiness _business;

  // (래핑할 대상 위젯)
  final Widget child;

  // [public 함수]

  // [private 함수]

  // [뷰 위젯]
  // !!!뷰 위젯 반환 콜백 작성 하기!!!
  Widget viewWidgetBuild({required BuildContext context}) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onSecondaryTapUp: (TapUpDetails details) {
          _business.show(details.globalPosition);
        },
        onLongPress: _business.longPressEnabled
            ? () {
                assert(_business.longPressOffset != null);
                _business.show(_business.longPressOffset!);
                _business.longPressOffset = null;
              }
            : null,
        onLongPressStart: _business.longPressEnabled
            ? (LongPressStartDetails details) {
                _business.longPressOffset = details.globalPosition;
              }
            : null,
        child: child);
  }
}

class ContextMenuRegionItemVo {
  ContextMenuRegionItemVo(
      {required this.menuItemWidget, required this.menuItemCallback});

  Widget menuItemWidget;
  void Function() menuItemCallback;
}
