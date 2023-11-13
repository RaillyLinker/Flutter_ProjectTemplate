// (external)
import 'package:flutter/cupertino.dart';

// [Stateful 위젯 샘플 템플릿]
// Stateful 위젯은 아래와 같이 만들면 좋습니다.

// StatefulWidget 의 State 에 접근 하려면, StatefulWidget 을 생성할 때 key 에,
// GlobalKey<StatefulWidgetTemplateState> statefulWidgetTemplateGk = GlobalKey();
// key : statefulWidgetTemplateGk
// 위와 같이 GlobalKey 객체를 넣어 주고, 이를 이용 하여,
// statefulWidgetTemplateGk.currentState?.refresh();
// 이처럼 currentState 를 사용 하면 됩니다.

// -----------------------------------------------------------------------------
class StatefulWidgetTemplate extends StatefulWidget {
  const StatefulWidgetTemplate(this.viewModel, {super.key});

  final StatefulWidgetTemplateViewModel viewModel;

  @override
  StatefulWidgetTemplateState createState() => StatefulWidgetTemplateState();
}

class StatefulWidgetTemplateViewModel {
  StatefulWidgetTemplateViewModel(this.sampleInt);

  // !!!State 에서 사용할 상태 변수 선언!!!
  int sampleInt;
}

class StatefulWidgetTemplateState extends State<StatefulWidgetTemplate> {
  // Stateful Widget 화면 갱신
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // !!!widget.viewModel 의 상태 변수를 반영한 하위 위젯 작성!!!
    return Text(widget.viewModel.toString());
  }
}
