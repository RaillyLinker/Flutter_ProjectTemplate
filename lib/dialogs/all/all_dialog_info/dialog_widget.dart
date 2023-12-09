// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';

// (inner Folder)
import 'dialog_widget_business.dart' as dialog_widget_business;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

//------------------------------------------------------------------------------
// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo(
      {required this.dialogTitle,
      required this.dialogContent,
      required this.checkBtnTitle});

  // 다이얼로그 타이틀
  final String dialogTitle;

  // 다이얼로그 본문
  final String dialogContent;

  // 확인 버튼 문구
  final String checkBtnTitle;
}

// (결과 데이터)
class OutputVo {
  // !!!위젯 출력값 선언!!!
  const OutputVo();
}

//------------------------------------------------------------------------------
class DialogWidget extends StatefulWidget {
  const DialogWidget(
      {super.key,
      required this.inputVo,
      required this.business,
      required this.onDialogCreated});

  final InputVo inputVo;

  // 다이얼로그가 Created 된 시점에 한번 실행됨
  final VoidCallback onDialogCreated;

  final dialog_widget_business.PageWidgetBusiness business;

  @override
  DialogWidgetState createState() => DialogWidgetState();
}

class DialogWidgetState extends State<DialogWidget>
    with WidgetsBindingObserver {
  // [콜백 함수]
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    business = widget.business;
    business.refreshUi = refreshUi;
    business.inputVo = widget.inputVo;
    business.viewModel =
        dialog_widget_business.PageWidgetViewModel(context: context);
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
          if (business.needInitState) {
            business.needInitState = false;
            widget.onDialogCreated();
          }

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
  late dialog_widget_business.PageWidgetBusiness business;

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
      required dialog_widget_business.PageWidgetBusiness business}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: SizedBox(
          width: 280,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 55,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 17, right: 17),
                  child: Center(
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      business.inputVo.dialogTitle,
                      style: const TextStyle(
                          fontSize: 17,
                          fontFamily: "MaruBuri",
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                height: 120,
                color: Colors.white,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17, right: 17),
                    child: SingleChildScrollView(
                      child: Text(
                        business.inputVo.dialogContent,
                        style: const TextStyle(
                            fontFamily: "MaruBuri", color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 0.1,
              ),
              Container(
                height: 55,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
                child: Center(
                  child: Container(
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 200),
                    child: ElevatedButton(
                      onPressed: () {
                        business.closeDialog(context: context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        business.inputVo.checkBtnTitle,
                        style: const TextStyle(
                            color: Colors.white, fontFamily: "MaruBuri"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
