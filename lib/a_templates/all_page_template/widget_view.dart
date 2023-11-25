// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;

// (all)
import '../../../global_widgets/gw_page_outer_frame/widget_view.dart'
    as gw_page_outer_frame_view;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

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

// (입력 데이터)
class InputVo {
  const InputVo();
// !!!위젯 입력값 선언!!!
}

// (결과 데이터)
class OutputVo {
  const OutputVo();
// !!!위젯 출력값 선언!!!
}

// -----------------------------------------------------------------------------
class WidgetView extends StatelessWidget {
  WidgetView({super.key, required GoRouterState goRouterState}) {
    business.setInputVo(goRouterState: goRouterState);
  }

  // [콜백 함수]
  // (위젯을 화면에 draw 할 때의 콜백)
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: business.canPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          business.onFocusGained();
        },
        onFocusLost: () async {
          business.onFocusLost();
        },
        onVisibilityGained: () async {
          business.onVisibilityGained();
        },
        onVisibilityLost: () async {
          business.onVisibilityLost();
        },
        onForegroundGained: () async {
          business.onForegroundGained();
        },
        onForegroundLost: () async {
          business.onForegroundLost();
        },
        child: viewWidgetBuild(context: context),
      ),
    );
  }

  // [public 변수]
  // (위젯 비즈니스)
  final widget_business.WidgetBusiness business =
      widget_business.WidgetBusiness();

  // [뷰 위젯]
  Widget viewWidgetBuild({required BuildContext context}) {
    return StatefulView(
      key: business.statefulGk,
      business: business,
    );
  }
}

class StatefulView extends StatefulWidget {
  const StatefulView({required super.key, required this.business});

  // [콜백 함수]
  @override
  StatefulBusiness createState() => StatefulBusiness();

  // [public 변수]
  // (위젯 비즈니스)
  final widget_business.WidgetBusiness business;
}

class StatefulBusiness extends State<StatefulView> with WidgetsBindingObserver {
  StatefulBusiness();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    widget.business.context = context;
    return WidgetUi.viewWidgetBuild(
        context: context, business: widget.business);
  }

  // [콜백 함수]
  // (페이지 위젯 initState)
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.business.initState();
  }

  // (페이지 위젯 dispose)
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    widget.business.dispose();
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
      required widget_business.WidgetBusiness business}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!
    return gw_page_outer_frame_view.WidgetView(
      business: business.pageOutFrameBusiness,
      inputVo: const gw_page_outer_frame_view.InputVo(
        pageTitle: "페이지 템플릿",
        child: Center(
          child: Text(
            "페이지 템플릿입니다.",
            style: TextStyle(fontFamily: "MaruBuri"),
          ),
        ),
      ),
    );
  }
}
