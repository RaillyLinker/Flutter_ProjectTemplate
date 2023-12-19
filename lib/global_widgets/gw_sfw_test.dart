// (external)
import 'package:flutter/material.dart';

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (Stateful Widget 예시)
class SfwTest extends StatefulWidget {
  const SfwTest({required super.key});

  // !!!외부 입력 변수 선언 하기!!!

  // [콜백 함수]
  @override
  SfwTestState createState() => SfwTestState();
}

class SfwTestState extends State<SfwTest> {
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return getScreenWidget();
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

  //----------------------------------------------------------------------------
  // !!!위젯 변수를 저장 하세요.!!!
  // [public 변수]
  // (샘플 정수)
  int sampleInt = 0;

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!위젯 함수를 작성 하세요.!!!
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

  // [private 함수]

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget() {
    // !!!위젯 화면을 작성 하세요.!!!

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          countPlus1();
        },
        child: Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black)),
          ),
          margin: const EdgeInsets.only(bottom: 20),
          child: Text("$sampleInt",
              style: const TextStyle(
                  fontSize: 20, color: Colors.black, fontFamily: "MaruBuri")),
        ),
      ),
    );
  }
}
