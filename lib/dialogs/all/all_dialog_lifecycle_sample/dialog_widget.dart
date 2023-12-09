// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (inner Folder)
import 'dialog_widget_state.dart' as dialog_widget_state;

// (all)
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_widgets/gw_stateful_test/sf_widget.dart'
    as gw_stateful_test;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
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

class DialogWidget extends StatefulWidget {
  const DialogWidget(
      {required this.globalKey,
      required this.inputVo,
      required this.onDialogCreated})
      : super(key: globalKey);

  // [콜백 함수]
  @override
  dialog_widget_state.DialogWidgetState createState() =>
      dialog_widget_state.DialogWidgetState();

  // [public 변수]
  final InputVo inputVo;
  final GlobalKey<dialog_widget_state.DialogWidgetState> globalKey;

  // 다이얼로그가 Created 된 시점에 한번 실행됨
  final VoidCallback onDialogCreated;

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context,
      required dialog_widget_state.DialogWidgetState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          height: 320,
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
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "글로벌 위젯 상태 변수",
                  style: TextStyle(color: Colors.black, fontFamily: "MaruBuri"),
                ),
                const SizedBox(
                  height: 5,
                ),
                gw_stateful_test.SfWidget(
                    globalKey: currentState.statefulTestGk,
                    inputVo: const gw_stateful_test.InputVo()),
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
                      currentState.onBlocSampleClicked();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black)),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: BlocProvider(
                        create: (context) => currentState.blocSampleBloc,
                        child: BlocBuilder<gc_template_classes.RefreshableBloc,
                            bool>(
                          builder: (c, s) {
                            return Text("${currentState.blocSampleIntValue}",
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
                ElevatedButton(
                    onPressed: () {
                      currentState.pushToAnotherPage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "페이지 이동",
                      style: TextStyle(
                          color: Colors.white, fontFamily: "MaruBuri"),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// (BLoC 갱신 구역 설정 방법)
// 위젯을 작성 하다가 특정 부분은 상태에 따라 UI 가 변하도록 하고 싶은 부분이 있습니다.
// 이 경우 Stateful 위젯을 생성 해서 사용 하면 되지만,
// 간단히 갱신 영역을 지정 하여 해당 구역만 갱신 하도록 하기 위해선 BLoC 갱신 구역을 설정 하여 사용 하면 됩니다.
// Widget State 클래스 안에 BLoC 갱신 구역 조작 객체로
// gc_template_classes.RefreshableBloc refreshableBloc = gc_template_classes.RefreshableBloc();
// 위와 같이 선언 및 생성 하고,
// Widget 에서는, 갱신 하려는 구역을
// BlocProvider(
//         create: (context) => currentState.refreshableBloc,
//         child: BlocBuilder<gc_template_classes.RefreshableBloc, bool>(
//         builder: (c,s){
//             return Text(currentState.sampleInt.toString());
//         },
//     ),
// )
// 위와 같이 감싸 줍니다.
// 만약 위와 같은 Text 위젯에서 숫자 표시를 갱신 하려면,
// currentState.sampleInt += 1;
// currentState.refreshableBloc.refreshUi();
// 이처럼 Text 위젯에서 사용 하는 상태 변수의 값을 변경 하고,
// 갱신 구역 객체의 refreshUi() 함수를 실행 시키면,
// builder 가 다시 실행 되며, 그 안의 위젯이 재조립 되어 화면을 갱신 합니다.
