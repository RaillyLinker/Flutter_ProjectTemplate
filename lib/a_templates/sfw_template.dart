// (external)
import 'package:flutter/cupertino.dart';

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (Stateful Widget 예시)
class SfwTemplate extends StatefulWidget {
  const SfwTemplate({required super.key});

  // !!!외부 입력 변수 선언 하기!!!

  // [콜백 함수]
  @override
  SfwTemplateState createState() => SfwTemplateState();
}

class SfwTemplateState extends State<SfwTemplate> {
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return getScreenWidget(context: context);
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

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // [private 함수]

  //----------------------------------------------------------------------------
  // [public 변수]

  // [private 변수]

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget({required BuildContext context}) {
    return const Text("Sample");
  }
}
