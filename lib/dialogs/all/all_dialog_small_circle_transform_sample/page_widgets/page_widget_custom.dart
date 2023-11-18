// (external)
import 'package:flutter/material.dart';

// [페이지 위젯 작성 파일]
// 페이지 뷰에서 사용할 위젯은 여기에 작성하여 사용하세요.

//------------------------------------------------------------------------------
// (Stateless 위젯 템플릿)
// class StatelessWidgetTemplate extends StatelessWidget {
//   const StatelessWidgetTemplate(this.viewModel, {required super.key});
//
//   // 위젯 뷰모델
//   final StatelessWidgetTemplateViewModel viewModel;
//
//   //!!!주입 받을 하위 위젯 선언 하기!!!
//
//   // !!!하위 위젯 작성하기. (viewModel 에서 데이터를 가져와 사용)!!!
//   @override
//   Widget build(BuildContext context) {
//     return Text(viewModel.sampleText);
//   }
// }
//
// class StatelessWidgetTemplateViewModel {
//   StatelessWidgetTemplateViewModel(this.sampleText);
//
//   // !!!위젯 상태 변수 선언하기!!!
//   final String sampleText;
// }

// (Stateful 위젯 템플릿)
// class StatefulWidgetTemplate extends StatefulWidget {
//   const StatefulWidgetTemplate(this.viewModel, {required super.key});
//
//   // 위젯 뷰모델
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

class OuterContainerForComplete extends StatefulWidget {
  const OuterContainerForComplete(this.viewModel, {super.key});

  final OuterContainerForCompleteViewModel viewModel;

  @override
  OuterContainerForCompleteState createState() =>
      OuterContainerForCompleteState();
}

class OuterContainerForCompleteViewModel {
  OuterContainerForCompleteViewModel();

  // !!!State 에서 사용할 상태 변수 선언!!!
  bool isComplete = false;
}

class OuterContainerForCompleteState extends State<OuterContainerForComplete> {
  // Stateful Widget 화면 갱신
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // !!!widget.viewModel 의 상태 변수를 반영한 하위 위젯 작성!!!
    return AnimatedContainer(
      width: widget.viewModel.isComplete ? 64 : 300,
      height: widget.viewModel.isComplete ? 64 : 220,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
      child: widget.viewModel.isComplete
          ? CompleteCircleContainer()
          : Container(
              height: 280,
              width: 300,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: const Center(
                child: Text("잠시 후 종료됩니다."),
              ),
            ),
    );
  }
}

// 작업 완료시 변경될 작은 원 위젯
class CompleteCircleContainer extends Container {
  CompleteCircleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),
                spreadRadius: 5,
                blurRadius: 7)
          ]),
      child: const Center(child: Text('성공')),
    );
  }
}
