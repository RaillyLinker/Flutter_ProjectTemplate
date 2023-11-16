// (external)
import 'package:flutter/cupertino.dart';

// [Stateful 위젯 샘플 템플릿]
// 본 프로젝트는 동적 위젯 작성에 BLoC 를 주로 사용합니다.
// 다만, 부득이 Stateful 위젯을 사용 해야 한다면 아래와 같이 만들면 좋습니다.

// -----------------------------------------------------------------------------
class StatefulWidgetTemplate extends StatefulWidget {
  const StatefulWidgetTemplate(this.viewModel, {super.key});

  final StatefulWidgetTemplateViewModel viewModel;

  @override
  StatefulWidgetTemplateState createState() => StatefulWidgetTemplateState();
}

class StatefulWidgetTemplateViewModel {
  StatefulWidgetTemplateViewModel(this.sampleInt);

  // !!!위젯 상태 변수 선언하기!!!
  int sampleInt;
}

class StatefulWidgetTemplateState extends State<StatefulWidgetTemplate> {
  // Stateful Widget 화면 갱신
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // 하위 위젯 작성하기. (widget.viewModel 에서 데이터를 가져와 사용)
    return Text(widget.viewModel.sampleInt.toString());
  }
}
