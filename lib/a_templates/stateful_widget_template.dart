// (external)
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// [Stateful 위젯 샘플 템플릿]
// Stateful 위젯은 아래와 같이 만들면 좋습니다.

// -----------------------------------------------------------------------------
class StatefulWidgetTemplate extends StatefulWidget {
  const StatefulWidgetTemplate(this.statefulWidgetTemplateState, {super.key});

  final StatefulWidgetTemplateState statefulWidgetTemplateState;

  @override
  // ignore: no_logic_in_create_state
  StatefulWidgetTemplateState createState() => statefulWidgetTemplateState;
}

class StatefulWidgetTemplateState extends State<StatefulWidgetTemplate> {
  // Stateful Widget 화면 갱신
  void refresh() {
    setState(() {});
  }

  // !!!위젯 상태 변수 선언하기!!!
  int sampleInt;

  StatefulWidgetTemplateState(this.sampleInt);

  @override
  Widget build(BuildContext context) {
    return Text(sampleInt.toString());
  }
}
