// (external)
import 'package:flutter/cupertino.dart';

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

// -----------------------------------------------------------------------------
// (Stateful Widget 예시)
class SfwTemplate extends StatefulWidget {
  const SfwTemplate({required this.globalKey}) : super(key: globalKey);

  // [콜백 함수]
  @override
  SfwTemplateState createState() => SfwTemplateState();

  // [public 변수]
  final GlobalKey<SfwTemplateState> globalKey;

  // !!!외부 입력 변수 선언 하기!!!

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context, required SfwTemplateState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return const Text("Sample");
  }
}

class SfwTemplateState extends State<SfwTemplate> {
  SfwTemplateState();

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

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }
}
