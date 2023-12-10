// (external)
import 'package:flutter/material.dart';

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (Stateful Widget 예시)
class SfwTest extends StatefulWidget {
  const SfwTest({required this.globalKey}) : super(key: globalKey);

  // [콜백 함수]
  @override
  SfwTestState createState() => SfwTestState();

  // [public 변수]
  final GlobalKey<SfwTestState> globalKey;

  // !!!외부 입력 변수 선언 하기!!!

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context, required SfwTestState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return MouseRegion(
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
          child: Text("${currentState.sampleInt}",
              style: const TextStyle(
                  fontSize: 20, color: Colors.black, fontFamily: "MaruBuri")),
        ),
      ),
    );
  }
}

class SfwTestState extends State<SfwTest> {
  SfwTestState();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return widget.widgetUiBuild(context: context, currentState: this);
  }

  @override
  void initState() {
    super.initState();
    // !!!initState 작성!!!
  }

  @override
  void dispose() {
    // !!!dispose 작성!!!
    super.dispose();
  }

  // [public 변수]
  // (샘플 정수)
  int sampleInt = 0;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // (화면 카운트 +1)
  void countPlus1() {
    sampleInt += 1;
    refreshUi();
  }
}
