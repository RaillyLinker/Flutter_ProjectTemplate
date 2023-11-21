// (external)
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// [위젯 템플릿]
// 위젯 작성은 아래와 같이 작성하면 좋습니다.

// -----------------------------------------------------------------------------
// (Stateless 위젯 템플릿)
class StatelessWidgetTemplate extends StatelessWidget {
  const StatelessWidgetTemplate({super.key, required this.business});

  // [위젯 관련 변수] - State 의 setState() 를 하면 초기화 됩니다.
  // (위젯 비즈니스)
  final StatelessWidgetTemplateBusiness business;

  // [내부 함수]
  @override
  Widget build(BuildContext context) {
    return Text(business.sampleText);
  }
}

class StatelessWidgetTemplateBusiness {
  StatelessWidgetTemplateBusiness({required this.sampleText});

  // [위젯 관련 변수] - State 내에서 상태가 유지 됩니다.
  // (샘플 변수)
  String sampleText;

  // [외부 공개 함수]
  // (샘플 외부 공개 함수)
  void sampleFunc({required String text}) {
    sampleText = text;
    _samplePrivateFunc(text: text);
  }

  // [내부 함수]
  // (샘플 내부 함수)
  void _samplePrivateFunc({required String text}) {
    if (kDebugMode) {
      print(text);
    }
  }
}

// (Stateful 위젯 템플릿)
class StatefulWidgetTemplate extends StatefulWidget {
  const StatefulWidgetTemplate({super.key, required this.business});

  // [위젯 관련 변수] - State 의 setState() 를 하면 초기화 됩니다.
  // (위젯 비즈니스)
  final StatefulWidgetTemplateBusiness business;

  // [내부 함수]
  @override
  // ignore: no_logic_in_create_state
  StatefulWidgetTemplateBusiness createState() => business;
}

class StatefulWidgetTemplateBusiness extends State<StatefulWidgetTemplate> {
  StatefulWidgetTemplateBusiness({required this.sampleText});

  // [위젯 관련 변수] - State 내에서 상태가 유지 됩니다.
  // (샘플 변수)
  String sampleText;

  // [외부 공개 함수]
  // (Stateful Widget 화면 갱신)
  void refresh() {
    setState(() {});
  }

  // (샘플 외부 공개 함수)
  void sampleFunc({required String text}) {
    sampleText = sampleText;
  }

  // [내부 함수]
  @override
  Widget build(BuildContext context) {
    return Text(sampleText);
  }
}
