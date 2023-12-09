// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget_business.dart' as page_widget_business;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget.dart'
    as gw_page_outer_frame;

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
  // !!!위젯 입력값 선언!!!
  const InputVo();
}

// (결과 데이터)
class OutputVo {
  // !!!위젯 출력값 선언!!!
  const OutputVo();
}

//------------------------------------------------------------------------------
class PageWidget extends StatefulWidget {
  const PageWidget({super.key, required this.goRouterState});

  final GoRouterState goRouterState;

  @override
  PageWidgetState createState() => PageWidgetState();
}

class PageWidgetState extends State<PageWidget> with WidgetsBindingObserver {
  // [콜백 함수]
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    business = page_widget_business.PageWidgetBusiness();
    business.refreshUi = refreshUi;
    business.onCheckPageInputVo(
        context: context, goRouterState: widget.goRouterState);
    business.viewModel =
        page_widget_business.PageWidgetViewModel(context: context);
    business.initState(context: context);
  }

  @override
  void dispose() {
    business.dispose(context: context);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    business.refreshUi = refreshUi;
    return PopScope(
      canPop: business.canPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          await business.onFocusGained(context: context);
        },
        onFocusLost: () async {
          await business.onFocusLost(context: context);
        },
        onVisibilityGained: () async {
          await business.onVisibilityGained(context: context);
        },
        onVisibilityLost: () async {
          await business.onVisibilityLost(context: context);
        },
        onForegroundGained: () async {
          await business.onForegroundGained(context: context);
        },
        onForegroundLost: () async {
          await business.onForegroundLost(context: context);
        },
        child: WidgetUi.viewWidgetBuild(context: context, business: business),
      ),
    );
  }

  // [public 변수]
  late page_widget_business.PageWidgetBusiness business;

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
      required page_widget_business.PageWidgetBusiness business}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return gw_page_outer_frame.SlWidget(
      business: business.viewModel.pageOutFrameBusiness,
      inputVo: const gw_page_outer_frame.InputVo(
        pageTitle: "페이지 템플릿",
        child: Center(
          child: Text("템플릿 페이지"),
        ),
      ),
    );
  }
}

// (Stateful Widget 예시)
// class SfWidget extends StatefulWidget {
//   const SfWidget({required this.globalKey}) : super(key: globalKey);
//
//   // [콜백 함수]
//   @override
//   SfWidgetState createState() => SfWidgetState();
//
//   // [public 변수]
//   final GlobalKey<SfWidgetState> globalKey;
//
//   // !!!외부 입력 변수 선언 하기!!!
//
//   // [화면 작성]
//   Widget widgetUiBuild(
//       {required BuildContext context, required SfWidgetState currentState}) {
//     // !!!뷰 위젯 반환 콜백 작성 하기!!!
//
//     return const Text("Sample");
//   }
// }
//
// class SfWidgetState extends State<SfWidget> {
//   SfWidgetState();
//
//   // [콜백 함수]
//   @override
//   Widget build(BuildContext context) {
//     return widget.widgetUiBuild(context: context, currentState: this);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // !!!initState 작성!!!
//   }
//
//   @override
//   void dispose() {
//     // !!!dispose 작성!!!
//     super.dispose();
//   }
//
//   // [public 변수]
//
//   // [private 변수]
//
//   // [public 함수]
//   // (Stateful Widget 화면 갱신)
//   void refreshUi() {
//     setState(() {});
//   }
// }

// (Stateless Widget 예시)
// class SlWidget extends StatelessWidget {
//   const SlWidget({super.key, required this.business});
//
//   // [public 변수]
//   final SlWidgetBusiness business;
//
//   // !!!외부 입력 변수 선언 하기!!!
//
//   // [콜백 함수]
//   // (위젯을 화면에 draw 할 때의 콜백)
//   @override
//   Widget build(BuildContext context) {
//     return widgetUiBuild(context: context);
//   }
//
//   // [화면 작성]
//   Widget widgetUiBuild({required BuildContext context}) {
//     // !!!뷰 위젯 반환 콜백 작성 하기!!!
//
//     return const Text("Sample");
//   }
// }
//
// class SlWidgetBusiness {
//   // [콜백 함수]
//
//   // [public 변수]
//
//   // [private 변수]
//
//   // [public 함수]
//
//   // [private 함수]
// }
