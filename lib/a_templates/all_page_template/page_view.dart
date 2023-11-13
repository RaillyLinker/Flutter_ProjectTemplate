// (external)
import 'package:flutter/material.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;

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
    return gw_page_out_frames.PageOutFrame(
      "페이지 템플릿",
      const Center(
        child: Text("페이지 템플릿입니다.", style: TextStyle(fontFamily: "MaruBuri")),
      ),
    );
  }
}

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
