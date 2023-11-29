// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'widget_business.dart' as widget_business;
import 'inner_widgets/iw_sample_number_text/sf_widget.dart'
    as iw_sample_number_text;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget.dart'
    as gw_page_outer_frame_view;
import '../../../global_widgets/gw_stateful_test/sf_widget.dart'
    as gw_stateful_test_view;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!!
// 폴더명과 동일하게 작성하세요.
const pageName = "all_page_just_page_test1";

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

//------------------------------------------------------------------------------
class WidgetView extends StatefulWidget {
  const WidgetView({super.key, required this.goRouterState});

  final GoRouterState goRouterState;

  @override
  WidgetViewState createState() => WidgetViewState();
}

class WidgetViewState extends State<WidgetView> with WidgetsBindingObserver {
  // [콜백 함수]
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    business = widget_business.WidgetBusiness();
    business.context = context;
    business.refreshUi = refreshUi;
    business.onCheckPageInputVoAsync(goRouterState: widget.goRouterState);
    business.initState();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    business.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
  late widget_business.WidgetBusiness business;

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

    return gw_page_outer_frame_view.SlWidget(
      business: business.pageOutFrameGk,
      inputVo: gw_page_outer_frame_view.InputVo(
        pageTitle: "페이지 Push 테스트1",
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
                gw_stateful_test_view.SfWidget(
                    globalKey: business.statefulTestGk,
                    inputVo: const gw_stateful_test_view.InputVo()),
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
                      business.goToJustPushTest1Page();
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
                      business.goToJustPushTest2Page();
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
