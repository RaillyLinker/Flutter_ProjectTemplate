// (external)

// (inner Folder)
import 'widget_view.dart' as widget_view;
import 'inner_widgets/iw_go_home_icon_button/widget_business.dart'
    as iw_go_home_icon_button_business;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

// -----------------------------------------------------------------------------
class WidgetBusiness {
  WidgetBusiness();

  // [public 변수]
  // (연결된 위젯 변수) - 생성자 실행 이후 not null
  widget_view.WidgetView? view;

  // goToHomeIconButtonBusiness
  final iw_go_home_icon_button_business.WidgetBusiness
      goToHomeIconButtonBusiness =
      iw_go_home_icon_button_business.WidgetBusiness();

// [private 변수]

// [public 함수]

// [private 함수]
}
