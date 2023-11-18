// (external)
import 'package:flutter/cupertino.dart';

// [위젯 템플릿]
// 위젯 작성은 아래와 같이 작성하면 좋습니다.
// Stateful, Stateless 공통으로 위젯 파라미터로 viewModel 과 하위 위젯을 받습니다.
// 하위 위젯과 뷰모델을 따로 받는 이유는, MVVM 패턴에서 VM(ViewModel) 과 V(View = 위젯) 를 나누기 위해서입니다.

// -----------------------------------------------------------------------------
// (Stateless 위젯 템플릿)
class StatelessWidgetTemplate extends StatelessWidget {
  const StatelessWidgetTemplate(this.viewModel, {required super.key});

  // 위젯 뷰모델
  final StatelessWidgetTemplateViewModel viewModel;

  //!!!주입 받을 하위 위젯 선언 하기!!!

  // !!!하위 위젯 작성하기. (viewModel 에서 데이터를 가져와 사용)!!!
  @override
  Widget build(BuildContext context) {
    return Text(viewModel.sampleText);
  }
}

class StatelessWidgetTemplateViewModel {
  StatelessWidgetTemplateViewModel(this.sampleText);

  // !!!위젯 상태 변수 선언하기!!!
  final String sampleText;
}

////
// (Stateful 위젯 템플릿)
class StatefulWidgetTemplate extends StatefulWidget {
  const StatefulWidgetTemplate(this.viewModel, {required super.key});

  // 위젯 뷰모델
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
