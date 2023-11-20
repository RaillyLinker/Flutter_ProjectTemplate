// (external)
import 'package:flutter/cupertino.dart';

// [위젯 템플릿]
// 위젯 작성은 아래와 같이 작성하면 좋습니다.

// -----------------------------------------------------------------------------
// (Stateless 위젯 템플릿)
class StatelessWidgetTemplate extends StatelessWidget {
  const StatelessWidgetTemplate({super.key, required this.business});

  // 위젯 비즈니스
  final StatelessWidgetTemplateBusiness business;

  //!!!주입 받을 하위 위젯 선언 하기!!!

  // !!!위젯 작성하기. (business 에서 데이터를 가져와 사용)!!!
  @override
  Widget build(BuildContext context) {
    return Text(business.sampleText);
  }
}

class StatelessWidgetTemplateBusiness {
  StatelessWidgetTemplateBusiness({required this.sampleText});

  // !!!위젯 상태 변수 선언하기!!!
  String sampleText;

  // !!!위젯 비즈니스 로직 작성하기!!!
  void sampleFunc({required String text}) {
    sampleText = sampleText;
  }
}

// (Stateful 위젯 템플릿)
class StatefulWidgetTemplate extends StatefulWidget {
  const StatefulWidgetTemplate({super.key, required this.business});

  // 위젯 비즈니스
  final StatefulWidgetTemplateBusiness business;

  //!!!주입 받을 하위 위젯 선언 하기!!!

  @override
  // ignore: no_logic_in_create_state
  StatefulWidgetTemplateBusiness createState() => business;
}

class StatefulWidgetTemplateBusiness extends State<StatefulWidgetTemplate> {
  StatefulWidgetTemplateBusiness({required this.sampleText});

  // Stateful Widget 화면 갱신
  void refresh() {
    setState(() {});
  }

  // !!!위젯 상태 변수 선언하기!!!
  String sampleText;

  // !!!위젯 비즈니스 로직 작성하기!!!
  void sampleFunc({required String text}) {
    sampleText = sampleText;
  }

  // !!!위젯 작성하기. (business 에서 데이터를 가져와 사용)!!!
  @override
  Widget build(BuildContext context) {
    return Text(sampleText);
  }
}
