// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget_business.dart' as page_widget_business;
import 'inner_widgets/iw_sample_number_text/sf_widget.dart'
    as iw_sample_number_text;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget.dart'
    as gw_page_outer_frame;
import '../../../global_widgets/gw_stateful_test/sf_widget.dart'
    as gw_stateful_test;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!!
// 폴더명과 동일하게 작성하세요.
const pageName = "all_page_just_page_test2";

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
    business.onCheckPageInputVo(goRouterState: widget.goRouterState);
    business.refreshUi = refreshUi;
    business.context = context;
    business.initState();
  }

  @override
  void dispose() {
    business.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    business.refreshUi = refreshUi;
    business.context = context;
    return PopScope(
      canPop: business.canPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          await business.onFocusGained();
        },
        onFocusLost: () async {
          await business.onFocusLost();
        },
        onVisibilityGained: () async {
          await business.onVisibilityGained();
        },
        onVisibilityLost: () async {
          await business.onVisibilityLost();
        },
        onForegroundGained: () async {
          await business.onForegroundGained();
        },
        onForegroundLost: () async {
          await business.onForegroundLost();
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
      business: business.pageOutFrameBusiness,
      inputVo: gw_page_outer_frame.InputVo(
        pageTitle: "페이지 Push 테스트2",
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "글로벌 위젯 상태 변수",
                  style: TextStyle(color: Colors.black, fontFamily: "MaruBuri"),
                ),
                const SizedBox(
                  height: 10,
                ),
                gw_stateful_test.SfWidget(
                    globalKey: business.statefulTestGk,
                    inputVo: const gw_stateful_test.InputVo()),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "로컬 위젯 상태 변수",
                  style: TextStyle(color: Colors.black, fontFamily: "MaruBuri"),
                ),
                const SizedBox(
                  height: 10,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      business.countPlus1();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black)),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: iw_sample_number_text.SfWidget(
                        globalKey: business.sampleNumberTextGk,
                        inputVo: const iw_sample_number_text.InputVo(),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      business.goToJustPushTest1Page(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "페이지 Push 테스트1 으로 이동",
                      style: TextStyle(
                          color: Colors.white, fontFamily: "MaruBuri"),
                    )),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      business.goToJustPushTest2Page(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "페이지 Push 테스트2 로 이동",
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
