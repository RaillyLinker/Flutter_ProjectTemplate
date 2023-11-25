// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;
import 'inner_widgets/iw_stateful_sample_number/widget_view.dart'
    as iw_stateful_sample_number_view;

// (all)
import '../../../global_widgets/gw_stateful_test/widget_view.dart'
    as gw_stateful_test_view;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

//------------------------------------------------------------------------------
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
  WidgetView({super.key, required this.business, required InputVo inputVo}) {
    business.inputVo = inputVo;
  }

  // [콜백 함수]
  // (위젯을 화면에 draw 할 때의 콜백)
  @override
  Widget build(BuildContext context) {
    return StatefulView(
      key: business.statefulGk,
      business: business,
    );
  }

  // [public 변수]
  // (위젯 비즈니스)
  final widget_business.WidgetBusiness business;
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
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    widget.business.context = context;
    return PopScope(
      canPop: widget.business.canPop,
      child: FocusDetector(
          // (페이지 위젯의 FocusDetector 콜백들)
          onFocusGained: () async {
            widget.business.onFocusGained();
          },
          onFocusLost: () async {
            widget.business.onFocusLost();
          },
          onVisibilityGained: () async {
            widget.business.onVisibilityGained();
          },
          onVisibilityLost: () async {
            widget.business.onVisibilityLost();
          },
          onForegroundGained: () async {
            widget.business.onForegroundGained();
          },
          onForegroundLost: () async {
            widget.business.onForegroundLost();
          },
          child: WidgetUi.viewWidgetBuild(
              context: context, business: widget.business)),
    );
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
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
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

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          height: 280,
          width: 300,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Center(
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
                gw_stateful_test_view.WidgetView(
                    inputVo: const gw_stateful_test_view.InputVo(),
                    business: business.statefulTestBusiness),
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
                iw_stateful_sample_number_view.WidgetView(
                  business: business.statefulSampleNumberBusiness,
                  inputVo: const iw_stateful_sample_number_view.InputVo(),
                ),
                ElevatedButton(
                    onPressed: () {
                      business.pushToAnotherPage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "페이지 이동",
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
