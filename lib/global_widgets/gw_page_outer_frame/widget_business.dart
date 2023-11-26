// (external)
import 'package:flutter/cupertino.dart';

// (inner Folder)
import 'widget_view.dart' as widget_view;
import 'inner_widgets/iw_go_home_icon_button/widget_business.dart'
    as iw_go_home_icon_button_business;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class WidgetBusiness {
  // [public 변수]
  // (위젯 Context)
  late BuildContext context;

  // (위젯 입력값)
  late widget_view.InputVo inputVo;

  // (goToHomeIconButtonBusiness)
  final iw_go_home_icon_button_business.WidgetBusiness
      goToHomeIconButtonBusiness =
      iw_go_home_icon_button_business.WidgetBusiness();

// [private 변수]

// [public 함수]

// [private 함수]
}