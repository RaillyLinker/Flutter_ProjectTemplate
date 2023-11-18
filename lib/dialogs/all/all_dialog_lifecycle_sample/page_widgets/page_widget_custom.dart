// (external)
import 'package:flutter/material.dart';

// [페이지 위젯 작성 파일]
// 페이지 뷰에서 사용할 위젯은 여기에 작성하여 사용하세요.

//------------------------------------------------------------------------------
// (Stateful Widget 생성 예시)
// class StatefulWidgetTemplate extends StatefulWidget {
//   const StatefulWidgetTemplate(this.viewModel, {required super.key});
//
//   // State 뷰모델
//   final StatefulWidgetTemplateViewModel viewModel;
//
//   //!!!주입 받을 하위 위젯 선언 하기!!!
//
//   @override
//   StatefulWidgetTemplateState createState() => StatefulWidgetTemplateState();
// }
//
// class StatefulWidgetTemplateViewModel {
//   StatefulWidgetTemplateViewModel(this.sampleInt);
//
//   // !!!위젯 상태 변수 선언하기!!!
//   int sampleInt;
// }
//
// class StatefulWidgetTemplateState extends State<StatefulWidgetTemplate> {
//   // Stateful Widget 화면 갱신
//   void refresh() {
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // !!!하위 위젯 작성하기. (widget.viewModel 에서 데이터를 가져와 사용)!!!
//     return Text(widget.viewModel.sampleInt.toString());
//   }
// }

class StatefulWidgetSampleNumber extends StatefulWidget {
  const StatefulWidgetSampleNumber(this.viewModel, {super.key});

  final StatefulWidgetSampleNumberViewModel viewModel;

  @override
  StatefulWidgetSampleNumberState createState() =>
      StatefulWidgetSampleNumberState();
}

class StatefulWidgetSampleNumberViewModel {
  StatefulWidgetSampleNumberViewModel(this.sampleNumber);

  // !!!State 에서 사용할 상태 변수 선언!!!
  int sampleNumber;
}

class StatefulWidgetSampleNumberState
    extends State<StatefulWidgetSampleNumber> {
  // Stateful Widget 화면 갱신
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // !!!widget.viewModel 의 상태 변수를 반영한 하위 위젯 작성!!!
    return Text(widget.viewModel.sampleNumber.toString(),
        style: const TextStyle(
            fontSize: 20, color: Colors.black, fontFamily: "MaruBuri"));
  }
}
