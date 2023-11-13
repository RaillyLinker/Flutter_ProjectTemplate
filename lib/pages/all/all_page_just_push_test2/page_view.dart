// (external)
import 'package:flutter/material.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다.
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
      "페이지 Push 테스트2",
      Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _pageBusiness.countPlus1();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black)),
                    ),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: StatefulWidgetSampleNumber(
                      _pageBusiness.pageViewModel.statefulWidgetSampleNumberVm,
                      key: _pageBusiness
                          .pageViewModel.statefulWidgetSampleNumberStateGk,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    _pageBusiness.goToJustPushTest1Page();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "페이지 Push 테스트1 으로 이동",
                    style:
                        TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
                  )),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    _pageBusiness.goToJustPushTest2Page();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "페이지 Push 테스트2 로 이동",
                    style:
                        TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
                  )),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
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
