// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget_business.dart' as page_widget_business;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget.dart'
    as gw_page_outer_frame;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_widgets/gw_stateful_test/sf_widget.dart'
    as gw_stateful_test;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!!
// 폴더명과 동일하게 작성하세요.
const pageName = "all_page_stateful_and_lifecycle_test";

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
    business.pageWidgetViewModel =
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
      business: business.pageWidgetViewModel.pageOutFrameBusiness,
      inputVo: gw_page_outer_frame.InputVo(
        pageTitle: "Stateful 및 라이프사이클 테스트",
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "BLoC 상태 변수",
                  style: TextStyle(color: Colors.black, fontFamily: "MaruBuri"),
                ),
                const SizedBox(
                  height: 5,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      business.onBlocSampleClicked();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black)),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: BlocProvider(
                        create: (context) =>
                            business.pageWidgetViewModel.blocSampleBloc,
                        child: BlocBuilder<gc_template_classes.RefreshableBloc,
                            bool>(
                          builder: (c, s) {
                            return Text(
                                "${business.pageWidgetViewModel.blocSampleIntValue}",
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: "MaruBuri"));
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Stateful Widget 상태 변수",
                  style: TextStyle(color: Colors.black, fontFamily: "MaruBuri"),
                ),
                const SizedBox(
                  height: 5,
                ),
                gw_stateful_test.SfWidget(
                    globalKey: business.pageWidgetViewModel.statefulTestGk,
                    inputVo: const gw_stateful_test.InputVo()),
                ElevatedButton(
                    onPressed: () {
                      business.goToParentPage(context: context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "상위 페이지로 이동",
                      style: TextStyle(
                          color: Colors.white, fontFamily: "MaruBuri"),
                    )),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// (BLoC 위젯 예시)
// BlocProvider(
//         create: (context) => business.refreshableBloc,
//         child: BlocBuilder<gc_template_classes.RefreshableBloc, bool>(
//         builder: (c,s){
//             return Text(business.sampleInt.toString());
//         },
//     ),
// )
