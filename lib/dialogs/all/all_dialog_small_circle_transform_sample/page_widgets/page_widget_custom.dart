// (external)
import 'package:flutter/material.dart';

// [페이지 위젯 작성 파일]
// 페이지 뷰에서 사용할 위젯은 여기에 작성하여 사용하세요.

//------------------------------------------------------------------------------
// (Stateful Widget 생성 예시)
// class StatefulWidgetSample extends StatefulWidget {
//   const StatefulWidgetSample(this.viewModel, {super.key});
//
//   final StatefulWidgetSampleViewModel viewModel;
//
//   @override
//   StatefulWidgetSampleState createState() => StatefulWidgetSampleState();
// }
//
// class StatefulWidgetSampleViewModel {
//   StatefulWidgetSampleViewModel(this.sampleNumber);
//
//   // !!!State 에서 사용할 상태 변수 선언!!!
//   int sampleNumber;
// }
//
// class StatefulWidgetSampleState extends State<StatefulWidgetSample> {
//   // Stateful Widget 화면 갱신
//   void refresh() {
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // !!!widget.viewModel 의 상태 변수를 반영한 하위 위젯 작성!!!
//     return Text(widget.viewModel.sampleNumber.toString());
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