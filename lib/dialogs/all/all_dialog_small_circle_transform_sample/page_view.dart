// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (page)
import 'page_business.dart' as page_business;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다. (Widget 과 Business 간의 결합을 담당)
// 로직 처리는 pageBusiness 객체에 위임하세요.

//------------------------------------------------------------------------------
// (페이지 UI 위젯)
// !!!세부 화면 정의!!!
class PageView extends StatelessWidget {
  const PageView(this._pageBusiness, {super.key});

  // 페이지 비즈니스 객체
  final page_business.PageBusiness _pageBusiness;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Test(
          _pageBusiness.pageViewModel.sampleWidgetViewModel,
          key: _pageBusiness.pageViewModel.sampleWidgetStateGk,
        ),
      ),
    );
  }
}

// ex :
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

// (Stateful 위젯 템플릿)
// todo : 이것을 떼어내기
class Test extends StatefulWidget {
  const Test(this.viewModel, {required super.key});

  // 위젯 뷰모델
  final TestViewModel viewModel;

  //!!!주입 받을 하위 위젯 선언 하기!!!

  @override
  TestState createState() => TestState();
}

class TestViewModel {
  TestViewModel();

  // !!!위젯 상태 변수 선언하기!!!

  // 다이얼로그 작업 완료 여부
  bool isComplete = false;
}

class TestState extends State<Test> {
  // Stateful Widget 화면 갱신
  void refresh() {
    setState(() {});
  }

  // (다이얼로그 완료)
  Future<void> dialogComplete() async {
    widget.viewModel.isComplete = true;
    refresh();

    // 애니메이션의 지속 시간만큼 지연
    await Future.delayed(const Duration(milliseconds: 800));

    // 다이얼로그 닫기
    if (!context.mounted) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    // !!!하위 위젯 작성하기. (widget.viewModel 에서 데이터를 가져와 사용)!!!
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
