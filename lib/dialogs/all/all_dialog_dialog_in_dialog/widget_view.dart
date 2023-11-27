// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';

// (inner Folder)
import 'widget_business.dart' as widget_business;

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

//------------------------------------------------------------------------------
class WidgetView extends StatefulWidget {
  const WidgetView(
      {super.key,
      required this.business,
      required this.inputVo,
      required this.onDialogCreated});

  // 다이얼로그가 Created 된 시점에 한번 실행됨
  final VoidCallback onDialogCreated;

  @override
  WidgetViewState createState() => WidgetViewState();
  final widget_business.WidgetBusiness business;
  final InputVo inputVo;
}

class WidgetViewState extends State<WidgetView> with WidgetsBindingObserver {
  // [콜백 함수]
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    business = widget.business;
    business.context = context;
    business.inputVo = widget.inputVo;
    business.refreshUi = refreshUi;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    business.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: business.canPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          if (!business.onPageCreated) {
            await business.onCreated();
            widget.onDialogCreated();
            business.onPageCreated = true;
          }

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
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      business.showInfoDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "확인 다이얼로그 호출",
                      style: TextStyle(
                          color: Colors.white, fontFamily: "MaruBuri"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      business.showLoadingDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "로딩 스피너 다이얼로그 호출",
                      style: TextStyle(
                          color: Colors.white, fontFamily: "MaruBuri"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        business.showDialogInDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text("다중 다이얼로그 샘플 호출",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "MaruBuri")))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
