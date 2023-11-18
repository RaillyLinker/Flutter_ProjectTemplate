// (external)
import 'package:flutter/cupertino.dart';

// [Stateful 위젯 샘플 템플릿]
// Stateful 위젯을 사용 해야 한다면 아래와 같이 만들면 좋습니다.
// 외부에서 주입할 widget 은 StatefulWidget 의 파라미터로 받고, State 에 사용할 데이터는 ViewModel 에서 받습니다.
// 외부에서는 key 와 viewModel 을 저장해두고 사용하세요.

// -----------------------------------------------------------------------------
class StatefulWidgetTemplate extends StatefulWidget {
  const StatefulWidgetTemplate(this.viewModel, {required super.key});

  // State 뷰모델
  final StatefulWidgetTemplateViewModel viewModel;

  //!!!주입 받을 하위 위젯 선언 하기!!!

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
    // !!!하위 위젯 작성하기. (widget.viewModel 에서 데이터를 가져와 사용)!!!
    return Text(widget.viewModel.sampleInt.toString());
  }
}
