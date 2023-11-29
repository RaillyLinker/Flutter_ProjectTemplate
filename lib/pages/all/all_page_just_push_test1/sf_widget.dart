// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'sf_widget_state.dart' as sf_widget_state;
import 'inner_widgets/iw_sample_number_text/sf_widget.dart'
    as iw_sample_number_text;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget.dart'
    as gw_page_outer_frame_view;
import '../../../global_widgets/gw_stateful_test/sf_widget.dart'
    as gw_stateful_test_view;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.
// todo : state 가 유지되지 않는 문제가 있음. 아마 key 를 외부에서 제공해서 그런 것 같기도... 방법을 찾아보고 수정되면 템플릿에 적용하기

// -----------------------------------------------------------------------------
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
  // !!!위젯 입력값 선언!!!
  const InputVo();
}

// (결과 데이터)
class OutputVo {
  // !!!위젯 출력값 선언!!!
  const OutputVo();
}

// ignore: must_be_immutable
class SfWidget extends StatefulWidget {
  SfWidget({required this.globalKey, required this.goRouterState})
      : super(key: globalKey);

  // [콜백 함수]
  @override
  sf_widget_state.SfWidgetState createState() =>
      sf_widget_state.SfWidgetState();

  // [public 변수]
  final GoRouterState goRouterState;
  final GlobalKey<sf_widget_state.SfWidgetState> globalKey;
  late InputVo inputVo;

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context,
      required sf_widget_state.SfWidgetState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return gw_page_outer_frame_view.SlWidget(
      business: currentState.pageOutFrameGk,
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
                    globalKey: currentState.statefulTestGk,
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
                      currentState.countPlus1();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black)),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: iw_sample_number_text.SfWidget(
                        globalKey: currentState.sampleNumberTextGk,
                        inputVo: const iw_sample_number_text.InputVo(),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      currentState.goToJustPushTest1Page();
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
                      currentState.goToJustPushTest2Page();
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
