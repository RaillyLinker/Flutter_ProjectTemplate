// (external)
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;

// (all)
import '../../../global_widgets/gw_page_outer_frame/widget_view.dart'
    as gw_page_outer_frame_view;

// [페이지 진입 파일]
// 위젯의 화면 작성은 여기서 합니다.
// 할 수 있다면 외부에서 주입하는 데이터는 뷰의 생성자에서 받고,
// 비즈니스 생성 시점에 꼭 필요한 데이터만 비즈니스 생성자에서 받습니다.

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!!
// 폴더명과 동일하게 작성하세요.
const pageName = "all_page_template";

// !!!페이지 호출/반납 애니메이션!!!
// 동적으로 변경이 가능합니다.
Widget Function(BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child)
    pageTransitionsBuilder = (context, animation, secondaryAnimation, child) {
  return FadeTransition(opacity: animation, child: child);
};

// (페이지 호출시 필요한 입력값 데이터 형태)
// !!!페이지 입력 데이터 정의!!!
class InputVo {}

// (이전 페이지로 전달할 결과 데이터 형태)
// !!!페이지 반환 데이터 정의!!!
class OutputVo {}

// -----------------------------------------------------------------------------
class WidgetView extends StatefulWidget {
  WidgetView({super.key, required GoRouterState goRouterState}) {
    _business = widget_business.WidgetBusiness(goRouterState: goRouterState);
    _business.view = this;
  }

  // [콜백 함수]
  @override
  // ignore: no_logic_in_create_state
  widget_business.WidgetBusiness createState() => _business;

  // [public 변수]

  // [private 변수]
  // (위젯 비즈니스)
  late final widget_business.WidgetBusiness _business;

  // [public 함수]

  // [private 함수]

  // [뷰 위젯]
  // !!!뷰 위젯 반환 콜백 작성 하기!!!
  Widget viewWidgetBuild({required BuildContext context}) {
    return gw_page_outer_frame_view.WidgetView(
      pageTitle: "페이지 템플릿",
      business: _business.pageOutFrameBusiness,
      floatingActionButton: null,
      child: const Center(
        child: Text(
          "페이지 템플릿입니다.",
          style: TextStyle(fontFamily: "MaruBuri"),
        ),
      ),
    );
  }
}
